//
//  Jogo.m
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Jogo.h"
#import "NSDictionary+JSON.h"
#import "Usuario.h"

#define REST_ADDRESS_GET_QUIZ @"http://quiz-exmo.rhcloud.com/rest/quiz/get/%@"
#define REST_ADDRESS_ADD_POINTS @"http://quiz-exmo.rhcloud.com/rest/user/addPoints/%@/%i"


@implementation Jogo

@synthesize questoes, categoria;

- (void) prepararQuestoes{
    NSLog(@"Preparando as questões para a categoria: %@", categoria);    
    
    NSDictionary *result = [NSDictionary dictionaryWithContentsOfJSONURLString: [NSString stringWithFormat: REST_ADDRESS_GET_QUIZ, categoria ]];
    
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

- (int) informarPontuacao{
    
    Usuario *u = [Usuario sharedInstance];
    NSString *email = u.email;
    
    NSString *URL = [NSString stringWithFormat: REST_ADDRESS_ADD_POINTS, email, (int)[self pontuacao]];
    NSLog(@"URL: %@", URL);
                     
    NSDictionary *result = [NSDictionary dictionaryWithContentsOfJSONURLString:URL];
    
    int total = [[result objectForKey:@"points"] intValue];
    NSLog(@"Enviando os pontos %f, formando um total de %i", [self pontuacao], total);
    
    return total;
}

- (double) pontuacao{
    double total = 0;
    for (Questao *q in questoes) {
        if([[NSNumber numberWithInt:q.respostaCerta] isEqualToNumber:[NSNumber numberWithInt:q.respostaJogador ]]){
            total += 120;
        }
    }
    return total;
}

@end
