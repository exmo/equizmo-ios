//
//  Category.m
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 29/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Category.h"
#import "SoapConnection.h"

#define SOAP_ADDRESS @"https://quiz-exmo.rhcloud.com/quiz"
#define WSDL_TARGET_NAMESPACE @"http://webservice/"
#define OPERATION_LOGIN @"listCategories"
#define SOAP_ACTION @""


@interface Category()
@property (strong) id callbackTarget;
@property SEL callbackMethod;
@property (strong) NSString *currentName;
@property (strong) NSMutableString *currentValue;

@end

@implementation Category

@synthesize callbackMethod, callbackTarget, currentName, currentValue;
@synthesize categories;

-(void) loadCategoriesWithCallback: (SEL) method forInstance: (id) instance{
    callbackMethod = method;
    callbackTarget = instance;
    
    SoapConnection *soap = [[SoapConnection alloc]initWithSoapAddress:SOAP_ADDRESS targetNamespace:WSDL_TARGET_NAMESPACE operationName:OPERATION_LOGIN parameters:nil headers:nil];
    [soap loadServiceWithCallbak:@selector(extractCategoriasFromXML:) forInstance:self andFailureCallback:nil];
}

-(void) extractCategoriasFromXML: (NSString *)xml{
    [self parseXML: xml];
    [callbackTarget performSelectorOnMainThread:callbackMethod withObject:categories waitUntilDone:YES];
}

-(NSArray *)parseXML: (NSString *)xml{
    @try {
        NSData *data = [xml dataUsingEncoding:NSUTF8StringEncoding];
        NSXMLParser *xmlParserConnection = [[NSXMLParser alloc]initWithData:data];
        [xmlParserConnection setDelegate:self];
        categories = [[NSMutableArray alloc] init];
        [xmlParserConnection parse];
    }
    @catch (NSException *exception) {
        NSLog(@"Parser XML --> %@", exception);
    }
    @finally {
        return categories;
    }
}

#pragma mark NSXMLParseConnectionDelegate methods

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    currentName = nil;
    if([elementName rangeOfString:@"category"].length > 0){
        currentName = @"category";
        currentValue = [[NSMutableString alloc] init];
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if(currentName){
        [currentValue appendString:string];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if(currentName){
        [categories addObject:currentValue];
        currentName = nil;
    }   
    currentValue = nil;
}


@end
