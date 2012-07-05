//
//  SoapConnection.m
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 29/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SoapConnection.h"

@interface SoapConnection()
@property (strong) NSMutableData *responseData;
@property (strong) id target;
@property SEL method;
@property SEL failMethod;

@end

@implementation SoapConnection

@synthesize responseData, target, method, failMethod;

@synthesize soapAddress, targetNamespace, operationName, parameters, headers;

- (SoapConnection *) initWithSoapAddress: (NSString *)_soapAddress targetNamespace: (NSString *)_targetNamespace operationName: (NSString *)_operationName parameters: (NSDictionary *)_parameters headers: (NSDictionary *)_headers{

    self = [super init];
    
    self.soapAddress = _soapAddress;
    self.targetNamespace = _targetNamespace;
    self.operationName = _operationName;
    self.parameters = _parameters;

    return self;
}

-(NSString *) gerarEnvelope{
    
    NSMutableString* s = [NSMutableString string];
    [s appendFormat: @"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:web=\"%@\">", targetNamespace];
    [s appendString: @"<soapenv:Header>"];
    if(headers){
        NSEnumerator *enumerator = [headers keyEnumerator];
        id key;
        while ((key = [enumerator nextObject])) {
            [s appendFormat: @"<%@>%@</%@>", key, [headers objectForKey:key], key];
        }
    }
    [s appendString: @"</soapenv:Header>"];
    [s appendString: @"<soapenv:Body>"];
    [s appendFormat: @"<web:%@>", operationName];
    if(parameters){
        NSEnumerator *enumerator = [parameters keyEnumerator];
        id key;
        while ((key = [enumerator nextObject])) {
            [s appendFormat: @"<%@>%@</%@>", key, [parameters objectForKey:key], key];
        }
    }
    [s appendFormat: @"</web:%@>", operationName];
    [s appendString: @"</soapenv:Body>"];
    [s appendString: @"</soapenv:Envelope>"];
	return s; 
}


- (void)loadServiceWithCallbak: (SEL) _method forInstance: (id) _instance andFailureCallback: (SEL) _failMethod{
    
    target = _instance;
    method = _method;
    failMethod = _failMethod;
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:soapAddress]];
    
    NSString *envelope = [self gerarEnvelope];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [envelope length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: operationName forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [envelope dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
    
    if( theConnection ){
        responseData = [NSMutableData data];
    }else{
        NSLog(@"theConnection is NULL");
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // Show error message
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;
    NSLog(@"ERROR with theConenction: %@", error);
    if(target){
        if([target respondsToSelector:failMethod]){
            [target performSelectorOnMainThread:failMethod withObject:error waitUntilDone:NO];
        }else {
            NSLog(@"Objeto \"%@\" não responde por \"%@\"", target, failMethod);
        }
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // Use responseData
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;
    
    NSString *theXML = [[NSString alloc] initWithBytes: [responseData mutableBytes] length:[responseData length] encoding:NSUTF8StringEncoding];
    
    if(target){
        if([target respondsToSelector:method]){
            [target performSelectorOnMainThread:method withObject:theXML waitUntilDone:NO];
        }else {
            NSLog(@"Objeto \"%@\" não responde por \"%@\"", target, method);
        }
    }
    
}


@end
