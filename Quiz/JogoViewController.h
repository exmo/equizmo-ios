//
//  JogoViewController.h
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Jogo.h"

@interface JogoViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (retain, nonatomic) IBOutlet UILabel *labelCategoria;
@property (retain, nonatomic) IBOutlet UILabel *labelNome;
@property (retain, nonatomic) IBOutlet UILabel *labelPontos;
@property (retain, nonatomic) IBOutlet UILabel *labelNumeroDaPergunta;
@property (retain, nonatomic) IBOutlet UILabel *labelTotalDePerguntas;
@property (retain, nonatomic) IBOutlet UILabel *labelTempoDaResposta;
@property (retain, nonatomic) IBOutlet UILabel *labelPergunta;
@property (retain, nonatomic) IBOutlet UITableView *tabelaRespostas;

@property NSString *categoria;

@property Jogo *jogo;

@property UIViewController *mainModal;

@end
