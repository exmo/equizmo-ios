//
//  SelecionarCategoriaViewController.m
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CategoryViewController.h"
#import "GameViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Category.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController

@synthesize viewCategory;
@synthesize categoryList;
@synthesize activity;
@synthesize mainModel;
@synthesize tableCategory;

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [categoryList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"CelularProposicao";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    NSString  *category = [categoryList objectAtIndex:indexPath.row];    
    cell.textLabel.text = [NSString stringWithFormat:@" %@", category];

    return cell;
}

- (void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GameViewController *jogo = [[GameViewController alloc] init];
    jogo.category = [categoryList objectAtIndex:indexPath.row];
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
    
    viewCategory.layer.cornerRadius = 10;
    viewCategory.layer.masksToBounds = YES;
    viewCategory.layer.borderWidth = 3.0f;
    viewCategory.layer.borderColor = [UIColor orangeColor].CGColor; 
    
    
    
    categoryList = [NSArray arrayWithObjects: nil];
    [[[Category alloc]init] loadCategoriesWithCallback:@selector(reloadCategoryDataSource:) forInstance:self];
    [activity startAnimating];
}

- (void) reloadCategoryDataSource: (NSArray *) categories{
    categoryList = categories;
    [tableCategory reloadData];
    [activity stopAnimating];
}


- (void)viewDidUnload
{
    [self setViewCategory:nil];
    [self setTableCategory:nil];
    [self setActivity:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)cancel:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
