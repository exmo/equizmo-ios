//
//  RankingViewController.m
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RankingViewController.h"
#import "Usuario.h"
#import "Ranking.h"
#import "SelecionarCategoriaViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "LabelFormater.h"

@interface RankingViewController ()

@end

@implementation RankingViewController
@synthesize viewPontuacao;
@synthesize viewRanking;
@synthesize labelPontos;
@synthesize labelNome;
@synthesize tabela, lista;



#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [lista count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"CelularProposicao";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14.0];
    }
    
    Usuario  *usuario = (Usuario *)[lista objectAtIndex:indexPath.row];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *pontuacao = [formatter stringFromNumber:[NSNumber numberWithDouble:usuario.pontos]];
    
    cell.textLabel.text = [NSString stringWithFormat:@" %d - %@ (%@ pontos)", (indexPath.row+1), usuario.nome, pontuacao];
    
    
    //[LabelFormater resizeFontToFitLabel:cell.textLabel];
    
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
    
    viewPontuacao.layer.cornerRadius = 10;
    viewPontuacao.layer.masksToBounds = YES;
    viewPontuacao.layer.borderWidth = 3.0f;
    viewPontuacao.layer.borderColor = [UIColor orangeColor].CGColor; 
    
    viewRanking.layer.cornerRadius = 10;
    viewRanking.layer.masksToBounds = YES;
    viewRanking.layer.borderWidth = 3.0f;
    viewRanking.layer.borderColor = [UIColor whiteColor].CGColor; 

    
    lista = [Ranking listarPrimeiros:5];
    
    // Do any additional setup after loading the view, typically from a nib.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    labelNome.text = [defaults objectForKey:@"nome"];
    
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    labelPontos.text = [formatter stringFromNumber:[NSNumber numberWithDouble:[[defaults objectForKey:VAR_PONTOS] doubleValue]]];
    

    
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    lista = [Ranking listarPrimeiros:5];
    [tabela reloadData];
    
    Usuario *u = [[Usuario alloc]init];
    [u loadCurrent];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    labelPontos.text = [formatter stringFromNumber:[NSNumber numberWithDouble:u.pontos]];
}

- (void)viewDidUnload
{
    [self setTabela:nil];
    [self setLabelNome:nil];
    [self setLabelPontos:nil];
    [self setViewPontuacao:nil];
    [self setViewRanking:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)iniciarPartida:(id)sender {
    SelecionarCategoriaViewController *categorias = [[SelecionarCategoriaViewController alloc] init];
    categorias.mainModel = self;
    lista = nil;
    [self presentModalViewController:categorias animated:YES];
}

- (IBAction)exibirNoMapa:(id)sender {
}
@end
