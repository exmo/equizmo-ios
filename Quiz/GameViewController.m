//
//  JogoViewController.m
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameViewController.h"
#import "User.h"
#import "Question.h"
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>
#import "LabelFormater.h"
#import "Preference.h"

@interface GameViewController (){
    int currentQuestionIndex;
    NSArray *letters;
}

@property Preference *preference;

@end

@implementation GameViewController
@synthesize activity;
@synthesize labelCategory;
@synthesize labelName;
@synthesize labelPoints;
@synthesize labelIndexOfQuestion;
@synthesize labelNumberOfQuestions;
@synthesize labelEnunciation;
@synthesize tableAnswers;
@synthesize viewQuestionsAndPropositions;
@synthesize viewScore;
@synthesize viewResult;
@synthesize totalPoints;

@synthesize labelFinalScore;
@synthesize mainModal;

@synthesize game, category;

@synthesize preference;

#pragma mark LifeCycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        preference = [Preference load];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];
    
    viewScore.layer.cornerRadius = 10;
    viewScore.layer.masksToBounds = YES;
    viewScore.layer.borderWidth = 3.0f;
    viewScore.layer.borderColor = [UIColor orangeColor].CGColor; 
    
    viewQuestionsAndPropositions.layer.cornerRadius = 10;
    viewQuestionsAndPropositions.layer.masksToBounds = YES;
    viewQuestionsAndPropositions.layer.borderWidth = 3.0f;
    viewQuestionsAndPropositions.layer.borderColor = [UIColor whiteColor].CGColor;
    
    currentQuestionIndex = -1;
    
    [activity startAnimating];
    
    letters = [NSArray arrayWithObjects:@"a",@"b",@"c",@"d",@"e",@"f",@"g", nil];
    
    
    //Preparar os tocadores para não ter delay
    NSURL *url1 = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/success.mp3",[[NSBundle mainBundle] resourcePath]]];
    NSURL *url2 = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/fail.mp3",[[NSBundle mainBundle] resourcePath]]];
    playerCerto = [[AVAudioPlayer alloc] initWithContentsOfURL:url1 error:nil];
    playerErrado = [[AVAudioPlayer alloc] initWithContentsOfURL:url2 error:nil];
    [playerCerto prepareToPlay];
    [playerErrado prepareToPlay];    
    
    labelName.text = [User sharedInstance].name;

    game = [[Game alloc] init];
    game.category = category;
    
    [activity startAnimating];
    [game loadQuestions];
    [activity stopAnimating];
    
    labelCategory.text = category;
    labelNumberOfQuestions.text = [NSString stringWithFormat:@"%d", [game.questions count]];
    
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    preference = [Preference load];
    [self exibirProximaQuestao];
}

- (void)viewDidUnload
{
    [self setLabelCategory:nil];
    [self setLabelName:nil];
    [self setLabelPoints:nil];
    [self setLabelIndexOfQuestion:nil];
    [self setLabelNumberOfQuestions:nil];
    [self setLabelEnunciation:nil];
    [self setTableAnswers:nil];
    [self setViewQuestionsAndPropositions:nil];
    [self setViewScore:nil];
    [self setViewResult:nil];
    [self setLabelFinalScore:nil];
    [self setTableAnswers:nil];
    [self setTotalPoints:nil];
    [self setActivity:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(currentQuestionIndex<0)
        return 0;
    
    Question *q = [game.questions objectAtIndex:currentQuestionIndex];
    return [q.propositions count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellId = @"PropositionCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14.0];
    }
    Question *q = [game.questions objectAtIndex:currentQuestionIndex];
    NSString  *letter = [letters objectAtIndex:indexPath.row];
    NSString  *proposition = [q.propositions objectAtIndex:indexPath.row];    
    cell.textLabel.text = [NSString stringWithFormat:@"%@) %@",letter, proposition];
    [LabelFormater resizeFontToFitLabel: cell.textLabel maxSize:14.0 minSize:12.0];
    
    return cell;
}

- (void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(currentQuestionIndex < [game.questions count]){
        Question *q = [game.questions objectAtIndex:currentQuestionIndex];
        q.playerAnswer = indexPath.row;
        
        NSNumber *score = [NSNumber numberWithDouble:[game calculateScore]];
        labelPoints.text = [NSNumberFormatter localizedStringFromNumber:score
                                                                numberStyle:NSNumberFormatterDecimalStyle];
        
         UITableViewCell *cell=[_tableView cellForRowAtIndexPath:indexPath];
        preference = [Preference load];
        if([q isItRight]){
            cell.textLabel.highlightedTextColor = [UIColor greenColor];
            [playerErrado stop];
            if(preference.isSoundEnabled)
                [playerCerto play]; 
        }else{
            cell.textLabel.highlightedTextColor = [UIColor redColor];
            [playerCerto stop];
            if(preference.isSoundEnabled)
                [playerErrado play];
        }
        
        double delay = 0.5;
        
        if(preference.isSoundEnabled)
            delay = 1.5;
        
        [self performSelector:@selector(exibirProximaQuestao) withObject:nil afterDelay:delay];
        
    }
    
}

#pragma mark Metodos



-(void) exibirProximaQuestao{
    currentQuestionIndex++;
    if(currentQuestionIndex < [game.questions count]){
        [activity startAnimating];
        [UIView transitionWithView:viewQuestionsAndPropositions duration:0.8
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^ { 
                            
                            Question *q = [game.questions objectAtIndex:currentQuestionIndex];
                            labelEnunciation.text =  q.enunciation;
                            [LabelFormater resizeFontToFitLabel:labelEnunciation maxSize:20.0 minSize:15.0];
                            labelIndexOfQuestion.text = [NSString stringWithFormat:@"%d", currentQuestionIndex+1];
                            
                            [tableAnswers reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationRight];
                            
                            [activity stopAnimating];
                            
                        }
                        completion:nil];
        [activity stopAnimating];
        
    }else {
        // Envia para o servidor e exibe o resultado;
        [self encerrarJogo];
    }
}

- (void) encerrarJogo{
    [activity startAnimating];
    int total = [game sendScore];
    User *u = [User sharedInstance];
    u.points = total;
    [u saveAsCurrent];
    
    totalPoints.text = [NSString stringWithFormat:@"%i", total];
    
    viewResult.center = CGPointMake( self.view.frame.size.width/2, self.view.frame.size.height/2);
    viewResult.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.7];
    viewResult.layer.cornerRadius = 10;
    viewResult.layer.masksToBounds = YES;
    viewResult.layer.borderWidth = 3.0f;
    viewResult.layer.borderColor = [UIColor orangeColor].CGColor; 
    
    [UIView transitionWithView:self.view duration:0.8
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^ { 
                        [self.view addSubview:viewResult]; 
                        NSNumber *score = [NSNumber numberWithDouble:[game calculateScore]];
                        labelFinalScore.text = [NSNumberFormatter localizedStringFromNumber:score
                                                         numberStyle:NSNumberFormatterDecimalStyle];
                        [labelFinalScore setHidden:NO];
                    }
                    completion:nil];
    [activity stopAnimating];
}

/* Como estou trabalhando com telas modais, preciso fechar a primeira para que as demais fechem automáticamente
 * Para isso eu utilizo o ViewController da tela anterior e peço a ele para fechar o modal dele.
 */
- (void) fecharJanelas{
    if ([[mainModal parentViewController] respondsToSelector:@selector(dismissModalViewControllerAnimated:)]){
        [[mainModal parentViewController] dismissModalViewControllerAnimated:YES];
    } else {
        [[mainModal presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    }    
    
    [mainModal viewWillAppear:true];
}


- (IBAction)fechar:(id)sender {
    [self fecharJanelas];
}
@end
