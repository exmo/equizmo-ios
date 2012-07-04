//
//  SelecionarCategoriaViewController.m
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SelecionarCategoriaViewController.h"
#import "JogoViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Categoria.h"

@interface SelecionarCategoriaViewController ()

@end

@implementation SelecionarCategoriaViewController

@synthesize viewCategoria;
@synthesize lista;
@synthesize indicadorAtividade;
@synthesize mainModel;
@synthesize tabelaCategorias;

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
    
    NSString  *categoria = [lista objectAtIndex:indexPath.row];    
    cell.textLabel.text = [NSString stringWithFormat:@" %@", categoria];

    return cell;
}

- (void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JogoViewController *jogo = [[JogoViewController alloc] init];
    jogo.categoria = [lista objectAtIndex:indexPath.row];
    jogo.mainModal = self;
    [self presentModalViewController:jogo animated:YES];
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
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];
    
    viewCategoria.layer.cornerRadius = 10;
    viewCategoria.layer.masksToBounds = YES;
    viewCategoria.layer.borderWidth = 3.0f;
    viewCategoria.layer.borderColor = [UIColor orangeColor].CGColor; 
    
    
    
    lista = [NSArray arrayWithObjects: nil];
    [[[Categoria alloc]init]carregarCategoriasWithCallback:@selector(atualizarTabela:) forInstance:self];
    [indicadorAtividade startAnimating];
}

- (void) atualizarTabela: (NSArray *) categorias{
    lista = categorias;
    [tabelaCategorias reloadData];
    [indicadorAtividade stopAnimating];
}


- (void)viewDidUnload
{
    [self setViewCategoria:nil];
    [self setTabelaCategorias:nil];
    [self setIndicadorAtividade:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)cancelar:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
