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

-(void) saveAsCurrent{
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

- (void) logarWithCallback: (SEL) _method forInstance: (id) _instance{
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:nome forKey:@"name"]; 
    [parameters setObject:email forKey:@"email"]; 
    
    [parameters setObject:[NSNumber numberWithDouble:localizacao.coordinate.latitude] forKey:@"latitude"]; 
    [parameters setObject:[NSNumber numberWithDouble:localizacao.coordinate.longitude] forKey:@"longitude"]; 
    
    SoapConnection *soap = [[SoapConnection alloc]initWithSoapAddress:SOAP_ADDRESS targetNamespace:WSDL_TARGET_NAMESPACE operationName:OPERATION_LOGIN parameters:parameters headers:nil];
    
    [soap loadServiceWithCallbak:_method forInstance:_instance];
    
}

-(void) terminouLogin: (NSString *) xml{
    NSLog(@"Terminou Login: %@", xml);
    [self saveAsCurrent];
    
}

@end
