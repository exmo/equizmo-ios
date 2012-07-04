//
//  Jogo.m
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Jogo.h"
#import "SoapConnection.h"
#import "TBXML.h"

#define SOAP_ADDRESS @"https://quiz-exmo.rhcloud.com/quiz"
#define WSDL_TARGET_NAMESPACE @"http://webservice/"
#define OPERATION_LOGIN @"giveMeAQuizResponse"
#define SOAP_ACTION @""

@interface Jogo()
@property (strong) id target;
@property SEL method;

@end

@implementation Jogo

@synthesize questoes, categoria;
@synthesize method, target;

- (void) prepararQuestoes: (SEL) _method target: (id) _target{
    NSLog(@"Preparando as questões para a categoria: %@", categoria);
    
    self.target = _target;
    self.method = _method;
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObject:categoria forKey:@"category"];
    
    SoapConnection *soap = [[SoapConnection alloc]initWithSoapAddress:SOAP_ADDRESS targetNamespace:WSDL_TARGET_NAMESPACE operationName:OPERATION_LOGIN parameters:parameters headers:nil];
    
    [soap loadServiceWithCallbak:@selector(extrairJogoDoXml:) forInstance:self];
    
}


- (void) extrairJogoDoXml: (NSString *) xml{
    NSMutableArray *lista = [[NSMutableArray alloc] init]; 
    
    TBXML * tbxml = [[TBXML alloc] initWithXMLString:xml error:nil];
    TBXMLElement * root = tbxml.rootXMLElement;    
    TBXMLElement *pula = [TBXML childElementNamed:@"soap:Body" parentElement:root];
    pula = [TBXML childElementNamed:@"ns2:giveMeAQuizResponse" parentElement:pula];
    TBXMLElement *quiz = [TBXML childElementNamed:@"quiz" parentElement:pula];
    
    // Percorre as questões
    TBXMLElement * element = [TBXML childElementNamed:@"questions" parentElement:quiz];
    while (element){  
        Questao *questao = [[Questao alloc]init];
        
        TBXMLElement *resposta = [TBXML childElementNamed:@"answer" parentElement:quiz];
        questao.respostaCerta = [[TBXML textForElement:resposta] intValue]; 
        
        TBXMLElement *enunciado = [TBXML childElementNamed:@"enunciation" parentElement:quiz];
        questao.pergunta = [TBXML textForElement:enunciado];
        
        NSMutableArray *alternativas = [[NSMutableArray alloc]init];
        TBXMLElement * alternativa = [TBXML childElementNamed:@"propositions" parentElement:quiz];
        while (alternativa){
            [alternativas addObject:[TBXML textForElement:alternativa]];
            alternativa = alternativa->nextSibling;
        }
        questao.proposicoes = alternativas;
        
        [lista addObject:questao];
        // Próxima questão!
        element = element->nextSibling;
    }
    
    // Montou a lista de questões;
    questoes = lista;
    
    if([target respondsToSelector:method]){
        [target performSelector:method];
    }
    
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
