//
//  Jogo.m
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Jogo.h"
#import "NSDictionary+JSON.h"

#define REST_ADDRESS @"http://quiz-exmo.rhcloud.com/rest/quiz/get/%@"


@implementation Jogo

@synthesize questoes, categoria;

- (void) prepararQuestoes{
    NSLog(@"Preparando as questões para a categoria: %@", categoria);    
    
    NSDictionary *result = [NSDictionary dictionaryWithContentsOfJSONURLString: [NSString stringWithFormat: REST_ADDRESS, categoria ]];
    
    NSArray *questions = [result objectForKey:@"questions"];
    
    NSMutableArray *listaQuestoes = [[NSMutableArray alloc] init]; 
    for (NSDictionary *question in questions) {
        Questao *q = [[Questao alloc]init];
        q.pergunta = [question objectForKey:@"enunciation"];
        q.respostaCerta = [[question objectForKey:@"answer"] intValue];
        NSMutableArray *listaPropositions = [[NSMutableArray alloc] init]; 
        NSArray *propositions = [question objectForKey:@"propositions"];
        for (NSString *proposition in propositions) {
            [listaPropositions addObject:proposition];
        }
        q.proposicoes = listaPropositions;
        [listaQuestoes addObject:q];
    }
    questoes = listaQuestoes;
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
