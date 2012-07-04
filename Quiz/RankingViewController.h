//
//  RankingViewController.h
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RankingViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (retain, nonatomic) IBOutlet UILabel *labelPontos;
@property (retain, nonatomic) IBOutlet UILabel *labelNome;
@property (retain, nonatomic) IBOutlet UITableView *tabela;
@property NSArray *lista;

@property (retain, nonatomic) IBOutlet UIView *viewPontuacao;
@property (retain, nonatomic) IBOutlet UIView *viewRanking;

- (IBAction)iniciarPartida:(id)sender;
- (IBAction)exibirNoMapa:(id)sender;

@end
