//
//  Questao.h
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Questao : NSObject

@property NSString *pergunta;
@property int respostaCerta;
@property int respostaJogador;
@property NSArray *proposicoes;
@property int tempoDeResposta;

@end
