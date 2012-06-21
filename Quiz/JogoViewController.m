//
//  JogoViewController.m
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JogoViewController.h"
#import "Questao.h"
#import <QuartzCore/QuartzCore.h>
#import "ResultadoUIView.h"

@interface JogoViewController (){
    int indiceQuestaoAtual;
}

@end

@implementation JogoViewController
@synthesize labelCategoria;
@synthesize labelNome;
@synthesize labelPontos;
@synthesize labelNumeroDaPergunta;
@synthesize labelTotalDePerguntas;
@synthesize labelTempoDaResposta;
@synthesize labelPergunta;
@synthesize tabelaRespostas;

@synthesize mainModal;

@synthesize jogo, categoria;


#pragma mark LifeCycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    indiceQuestaoAtual = -1;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    labelNome.text = [defaults objectForKey:@"nome"];

    jogo = [[Jogo alloc] init];
    jogo.categoria = categoria;
    
    [jogo prepararQuestoes];
    
    labelCategoria.text = categoria;
    labelTotalDePerguntas.text = [NSString stringWithFormat:@"%d", [jogo.questoes count]];
    
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self exibirProximaQuestao];
}

- (void)viewDidUnload
{
    [self setLabelCategoria:nil];
    [self setLabelNome:nil];
    [self setLabelPontos:nil];
    [self setLabelNumeroDaPergunta:nil];
    [self setLabelTotalDePerguntas:nil];
    [self setLabelTempoDaResposta:nil];
    [self setLabelPergunta:nil];
    [self setTabelaRespostas:nil];
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
    if(indiceQuestaoAtual<0)
        return 0;
    
    Questao *q = [jogo.questoes objectAtIndex:indiceQuestaoAtual];
    return [q.proposicoes count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"CelularProposicao";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    Questao *q = [jogo.questoes objectAtIndex:indiceQuestaoAtual];
    NSString  *proposicao = [q.proposicoes objectAtIndex:indexPath.row];    
    cell.textLabel.text = [NSString stringWithFormat:@" %@", proposicao];
    
    return cell;
}

- (void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indiceQuestaoAtual < [jogo.questoes count]){
        Questao *q = [jogo.questoes objectAtIndex:indiceQuestaoAtual];
        q.respostaJogador = indexPath.row;
        
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        NSString *totalPontos = [formatter stringFromNumber:[NSNumber numberWithDouble:[jogo pontuacao]]];
        labelPontos.text = totalPontos;
        
        [self exibirProximaQuestao];
    }
    
}

#pragma mark Metodos
-(void) exibirProximaQuestao{
    indiceQuestaoAtual++;
    if(indiceQuestaoAtual < [jogo.questoes count]){
        Questao *q = [jogo.questoes objectAtIndex:indiceQuestaoAtual];
        labelPergunta.text =  q.pergunta;
        labelNumeroDaPergunta.text = [NSString stringWithFormat:@"%d", indiceQuestaoAtual+1];
        [tabelaRespostas reloadData];
    }else {
        [self encerrarJogo];
    }
}

- (void) encerrarJogo{
    
    UIView *bgView = [[UIView alloc] initWithFrame: self.view.bounds];
    bgView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.7];

    
    [self.view addSubview: bgView];
    
    //faux view
    UIView* fauxView = [[UIView alloc] initWithFrame: CGRectMake(10, 10, 200, 200)];
    fauxView.backgroundColor = [UIColor redColor];
    [bgView addSubview: fauxView];
    
    //the new panel
//    ResultadoUIView *bigPanelView = [[ResultadoUIView alloc] initWithFrame:CGRectMake(0, 0, bgView.frame.size.width * 0.8, bgView.frame.size.height * 0.8)];

    ResultadoUIView *bigPanelView = [[[NSBundle mainBundle] loadNibNamed:@"ResultadoUIView" owner:self options:nil] objectAtIndex:0];
    
    bigPanelView.frame = CGRectMake(0, 0, bgView.frame.size.width * 0.8, bgView.frame.size.height * 0.8);
    bigPanelView.center = CGPointMake( bgView.frame.size.width/2, bgView.frame.size.height/2);
    
//    //[ … Here add the window contents inside bigPanelView …]
//    bigPanelView.layer.cornerRadius = 10;
//    bigPanelView.layer.masksToBounds = YES;
//    bigPanelView.layer.borderWidth = 3.0f;
//    bigPanelView.layer.borderColor = [UIColor blueColor].CGColor; 
//    bigPanelView.backgroundColor = [UIColor whiteColor];
//    
//    //Botao fechar
//    int fecharOffset = 10;
//    UIImage* fecharImg = [UIImage imageNamed:@"popupCloseBtn"];
//    UIButton* fechar = [UIButton buttonWithType:UIButtonTypeCustom];
//    [fechar setImage:fecharImg forState:UIControlStateNormal];
//    [fechar setFrame:CGRectMake( bigPanelView.frame.origin.x + bigPanelView.frame.size.width - fecharImg.size.width - fecharOffset -30, 
//                                  bigPanelView.frame.origin.y +100 ,
//                                  fecharImg.size.width + fecharOffset, 
//                                  fecharImg.size.height + fecharOffset)];
//    [fechar addTarget:self action:@selector(fecharJanelas) forControlEvents:UIControlEventTouchUpInside];
//    [bigPanelView addSubview: fechar];
//    
//   
//    [bgView addSubview:bigPanelView];

    
    //animation options
    UIViewAnimationOptions options = UIViewAnimationOptionTransitionCurlUp | UIViewAnimationOptionBeginFromCurrentState;
    
    //run the animation
    [UIView transitionFromView:fauxView toView:bigPanelView duration:0.5 options:options completion: ^(BOOL finished) {
        //[ … some completion event handler … ]
        NSLog(@"Exibindo o painel...");
    }];
    
    
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
}


@end
