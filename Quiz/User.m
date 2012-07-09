//
//  User.m
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "User.h"
#import "SoapConnection.h"

#define SOAP_ADDRESS @"https://quiz-exmo.rhcloud.com/user"
#define WSDL_TARGET_NAMESPACE @"http://webservice/"
#define OPERATION_LOGIN @"login"
#define SOAP_ACTION @""

@interface User()
@end

@implementation User


@synthesize name, email, location, points;

static User *sharedInstance = nil;

- (id)init{
	if (self = [super init]) {
//		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveAsCurrent) name:UIApplicationWillTerminateNotification object:nil];
//		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveAsCurrent) name:UIApplicationDidEnterBackgroundNotification object:nil];
	}
	return self;
}

#pragma mark Singleton methods

+ (User *)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil){
			sharedInstance = [[User alloc] init];
            [sharedInstance loadCurrent];
        }
            
    }
    return sharedInstance;
}


-(void) saveAsCurrent{
    NSLog(@"Salvando os dados do usuário como default: %@", email);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:email forKey:VAR_EMAIL];
    [defaults setObject:name forKey:VAR_NAME];
    [defaults setObject:[NSNumber numberWithDouble:points ] forKey:VAR_POINTS];
    [defaults synchronize];
}

-(void) loadCurrent{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    name = [defaults objectForKey:VAR_NAME];
    email = [defaults objectForKey:VAR_EMAIL];
    points = [[defaults objectForKey:VAR_POINTS] doubleValue];
}

- (void) login{
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:name forKey:@"name"]; 
    [parameters setObject:email forKey:@"email"]; 
    [parameters setObject:[NSNumber numberWithDouble:location.coordinate.latitude] forKey:@"latitude"]; 
    [parameters setObject:[NSNumber numberWithDouble:location.coordinate.longitude] forKey:@"longitude"]; 
    
    SoapConnection *soap = [[SoapConnection alloc]initWithSoapAddress:SOAP_ADDRESS targetNamespace:WSDL_TARGET_NAMESPACE operationName:OPERATION_LOGIN parameters:parameters headers:nil];
    
    [soap loadServiceWithCallbak:@selector(didLoginWithXML:) forInstance:self andFailureCallback:@selector(didLoginWithError:)];
    
}

-(void) didLoginWithXML: (NSString *) xml{
    NSLog(@"Loggin successfull: %@", xml);
    NSRange range1 = [xml rangeOfString:@"<return>"];
    NSRange range2 = [xml rangeOfString:@"</return>"];
    
    int p1 = range1.location+range1.length;
    int p2 = range2.location - p1;
    NSString *pontuacaoAtual = [xml substringWithRange:NSMakeRange(p1,p2)];
    points = [pontuacaoAtual doubleValue]; 
    [self saveAsCurrent];
    
    NSLog(@"Sending event: %@", EVENT_LOGIN_OK);
    [[NSNotificationCenter defaultCenter] postNotificationName: EVENT_LOGIN_OK object:self];
    
}

/* Aqui podemos tratar o erro e enviar o evento correto ou apenas enviar o erro para o método que receber tratar.*/
-(void) didLoginWithError: (NSError *) error{
    NSLog(@"%@ Error saving context: %@", [self class], [error localizedDescription]);
    [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_LOGIN_FAIL object:error];
    
}

@end
