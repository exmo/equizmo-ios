//
//  RankingViewController.m
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RankingViewController.h"
#import "Usuario.h"
#import "SelecionarCategoriaViewController.h"
#import <QuartzCore/QuartzCore.h>

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
    }
    
    Usuario  *usuario = (Usuario *)[lista objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@" %d - %@ (%f pontos)", (indexPath.row+1), usuario.nome, usuario.pontos];
    
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
    
    // Do any additional setup after loading the view from its nib.
    
    Usuario *u1 = [[Usuario alloc] init];
    u1.nome = @"Nome 1";
    u1.pontos = 10.0;

    Usuario *u2 = [[Usuario alloc] init];
    u2.nome = @"Nome 2";
    u2.pontos = 9.0;    
    
    lista = [NSArray arrayWithObjects:u1, u2, nil ];
    
    // Do any additional setup after loading the view, typically from a nib.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    labelNome.text = [defaults objectForKey:@"nome"];
    
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
    [self presentModalViewController:categorias animated:YES];
}

- (IBAction)exibirNoMapa:(id)sender {
}
@end
