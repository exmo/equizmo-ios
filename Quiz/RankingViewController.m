//
//  RankingViewController.m
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RankingViewController.h"
#import "Ranking.h"
#import "User.h"
#import "CategoryViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface RankingViewController ()

@end

@implementation RankingViewController
@synthesize viewScore;
@synthesize viewRanking;
@synthesize labelPoints;
@synthesize labelName;
@synthesize table, users;



#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [users count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"propositionCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14.0];
    }
    
    User *user = (User *)[users objectAtIndex:indexPath.row];
    
    NSString *score = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithDouble:user.points]
                                                        numberStyle:NSNumberFormatterDecimalStyle];
    
    cell.textLabel.text = [NSString stringWithFormat:@" %d - %@ (%@)", (indexPath.row+1), user.name, score];
    
    return cell;
}



#pragma mark ViewController Life Cycle

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
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];
    
    viewScore.layer.cornerRadius = 10;
    viewScore.layer.masksToBounds = YES;
    viewScore.layer.borderWidth = 3.0f;
    viewScore.layer.borderColor = [UIColor orangeColor].CGColor; 
    
    viewRanking.layer.cornerRadius = 10;
    viewRanking.layer.masksToBounds = YES;
    viewRanking.layer.borderWidth = 3.0f;
    viewRanking.layer.borderColor = [UIColor whiteColor].CGColor; 
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateDataOnScreen];
}

- (void) updateDataOnScreen{
    NSLog(@"Carregando dados para tela de ranking!");
    
    User *u = [User sharedInstance];
    labelName.text = u.name;
    
    NSNumber *score = [NSNumber numberWithDouble:u.points];
    labelPoints.text = [NSNumberFormatter localizedStringFromNumber:score
                                                        numberStyle:NSNumberFormatterDecimalStyle];
    
    
    users = [Ranking firsts:5];
    [table reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)viewDidUnload
{
    [self setTable:nil];
    [self setLabelName:nil];
    [self setLabelPoints:nil];
    [self setViewScore:nil];
    [self setViewRanking:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)logout:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)startGame:(id)sender {
    CategoryViewController *categorias = [[CategoryViewController alloc] init];
    categorias.mainModel = self;
    users = nil;
    [self presentModalViewController:categorias animated:YES];
}

- (IBAction)exibirNoMapa:(id)sender {

}
@end
