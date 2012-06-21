//
//  Jogo.h
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Questao.h"

@interface Jogo : NSObject

@property NSString *categoria;
@property NSArray *questoes;

- (void) prepararQuestoes;
- (double) pontuacao;

@end
