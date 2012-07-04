//
//  Questao.m
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Questao.h"

@implementation Questao

@synthesize pergunta, proposicoes, respostaCerta, respostaJogador, tempoDeResposta;


- (BOOL) estaCerto{
    
    return [[NSNumber numberWithInt:respostaCerta] isEqualToNumber:[NSNumber numberWithInt:respostaJogador ]];
}

@end
