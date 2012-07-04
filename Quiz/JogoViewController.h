//
//  JogoViewController.h
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Jogo.h"
#import <AVFoundation/AVFoundation.h>

@interface JogoViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    AVAudioPlayer *playerCerto;
    AVAudioPlayer *playerErrado;
}
@property (unsafe_unretained, nonatomic) IBOutlet UIActivityIndicatorView *atividade;
@property (retain, nonatomic) IBOutlet UILabel *labelCategoria;
@property (retain, nonatomic) IBOutlet UILabel *labelNome;
@property (retain, nonatomic) IBOutlet UILabel *labelPontos;
@property (retain, nonatomic) IBOutlet UILabel *labelNumeroDaPergunta;
@property (retain, nonatomic) IBOutlet UILabel *labelTotalDePerguntas;
@property (retain, nonatomic) IBOutlet UILabel *labelTempoDaResposta;
@property (retain, nonatomic) IBOutlet UILabel *labelPergunta;
@property (retain, nonatomic) IBOutlet UITableView *tabelaRespostas;
@property (retain, nonatomic) IBOutlet UIView *viewPerguntaRespostas;
@property (retain, nonatomic) IBOutlet UIView *viewPontuacao;
@property (strong, nonatomic) IBOutlet UIView *resultadoView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *totalPontos;

@property NSString *categoria;

@property Jogo *jogo;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *labelPontuacaoFinal;

@property UIViewController *mainModal;
- (IBAction)fechar:(id)sender;

@end
