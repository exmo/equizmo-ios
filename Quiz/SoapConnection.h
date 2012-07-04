//
//  SoapConnection.h
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 29/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SoapConnection : NSObject<NSURLConnectionDelegate>

@property NSString *soapAddress;
@property NSString *targetNamespace;
@property NSString *operationName;
@property NSDictionary *parameters;
@property NSDictionary *headers;


- (SoapConnection *) initWithSoapAddress: (NSString *)_soapAddress targetNamespace: (NSString *)_targetNamespace operationName: (NSString *)_operationName parameters: (NSDictionary *)_parameters headers: (NSDictionary *)_headers;

- (void)loadServiceWithCallbak: (SEL) _method forInstance: (id) _instance;

@end
