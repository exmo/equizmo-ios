//
//  Jogo.m
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Jogo.h"

@implementation Jogo

@synthesize questoes, categoria;

- (void) prepararQuestoes{
    
    NSLog(@"Preparando as questões para a categoria: %@", categoria);
    
    Questao *q1 = [[Questao alloc]init];
    q1.pergunta = @"Quem matou maria préa?";
    q1.proposicoes = [NSArray arrayWithObjects:@"Serge", @"Marlon", @"Robson", @"Sister Dulce", nil];
    q1.respostaCerta = 3;
    
    Questao *q2 = [[Questao alloc]init];
    q2.pergunta = @"Qual o time que mais estreou a libertadores no brasil?";
    q2.proposicoes = [NSArray arrayWithObjects:@"Internacional", @"Bahia", @"Santos", @"Flamengo", nil];
    q2.respostaCerta = 1;
    
    Questao *q3 = [[Questao alloc]init];
    q3.pergunta = @"Quem será campeão em 2012?";
    q3.proposicoes = [NSArray arrayWithObjects:@"Internacional", @"Bahia", @"Santos", @"Flamengo", nil];
    q3.respostaCerta = 1;
    
    questoes = [NSArray arrayWithObjects:q1,q2,q3, nil];
    
}

- (double) pontuacao{
    
    double total = 0;
    
    for (Questao *q in questoes) {
        NSLog(@"Pergunta: %@ \n Respondeu: %d (%@ )e o certo era %d (%@)",q.pergunta, q.respostaJogador,[q.proposicoes objectAtIndex:q.respostaJogador], q.respostaCerta, [q.proposicoes objectAtIndex:q.respostaCerta]);
        
        if([[NSNumber numberWithInt:q.respostaCerta] isEqualToNumber:[NSNumber numberWithInt:q.respostaJogador ]]){
            total = total + 100;
        }
        NSLog(@"Total %f",total);
        
    }
    
    return total;
}

@end
