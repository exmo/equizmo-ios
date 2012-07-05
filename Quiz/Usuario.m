//
//  Usuario.m
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Usuario.h"
#import "SoapConnection.h"

#define SOAP_ADDRESS @"https://quiz-exmo.rhcloud.com/user"
#define WSDL_TARGET_NAMESPACE @"http://webservice/"
#define OPERATION_LOGIN @"login"
#define SOAP_ACTION @""

@interface Usuario()
@end

@implementation Usuario


@synthesize nome, email, localizacao, pontos;

static Usuario *sharedInstance = nil;

- (id)init{
	if (self = [super init]) {
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveAsCurrent) name:UIApplicationWillTerminateNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveAsCurrent) name:UIApplicationDidEnterBackgroundNotification object:nil];
	}
	return self;
}

#pragma mark Singleton methods

+ (Usuario*)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil){
			sharedInstance = [[Usuario alloc] init];
            [sharedInstance loadCurrent];
        }
            
    }
    return sharedInstance;
}


-(void) saveAsCurrent{
    NSLog(@"Salvando os dados do usuário como default: %@", email);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:email forKey:VAR_EMAIL];
    [defaults setObject:nome forKey:VAR_NOME];
    [defaults setObject:[NSNumber numberWithDouble:pontos ] forKey:VAR_PONTOS];
    [defaults synchronize];
}

-(void) loadCurrent{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    nome = [defaults objectForKey:VAR_NOME];
    email = [defaults objectForKey:VAR_EMAIL];
    pontos = [[defaults objectForKey:VAR_PONTOS] doubleValue];
}

- (void) logar{
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:nome forKey:@"name"]; 
    [parameters setObject:email forKey:@"email"]; 
    [parameters setObject:[NSNumber numberWithDouble:localizacao.coordinate.latitude] forKey:@"latitude"]; 
    [parameters setObject:[NSNumber numberWithDouble:localizacao.coordinate.longitude] forKey:@"longitude"]; 
    
    SoapConnection *soap = [[SoapConnection alloc]initWithSoapAddress:SOAP_ADDRESS targetNamespace:WSDL_TARGET_NAMESPACE operationName:OPERATION_LOGIN parameters:parameters headers:nil];
    
    [soap loadServiceWithCallbak:@selector(terminouLogin:) forInstance:self andFailureCallback:@selector(falhouLogin:)];
    
}

-(void) terminouLogin: (NSString *) xml{
    NSLog(@"Terminou Login: %@", xml);
    NSRange range1 = [xml rangeOfString:@"<return>"];
    NSRange range2 = [xml rangeOfString:@"</return>"];
    
    int p1 = range1.location+range1.length;
    int p2 = range2.location - p1;
    NSString *pontuacaoAtual = [xml substringWithRange:NSMakeRange(p1,p2)];
    pontos = [pontuacaoAtual doubleValue]; 
    [self saveAsCurrent];
    
    NSLog(@"Enviando evento: usuarioSeLogou");
    [[NSNotificationCenter defaultCenter] postNotificationName: EVENTO_LOGIN_OK object:self];
    
}

/* Aqui podemos tratar o erro e enviar o evento correto ou apenas enviar o erro para o método que receber tratar.*/
-(void) falhouLogin: (NSError *) erro{
    NSLog(@"%@ Error saving context: %@", [self class], [erro localizedDescription]);
    [[NSNotificationCenter defaultCenter] postNotificationName:EVENTO_LOGIN_FAIL object:erro];
    
}

@end
