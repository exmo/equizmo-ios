//
//  Categoria.m
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 29/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Categoria.h"
#import "SoapConnection.h"

#define SOAP_ADDRESS @"https://quiz-exmo.rhcloud.com/quiz"
#define WSDL_TARGET_NAMESPACE @"http://webservice/"
#define OPERATION_LOGIN @"listCategories"
#define SOAP_ACTION @""


@interface Categoria()
@property (strong) id _instancia;
@property SEL _metodo;
@property (strong) NSString *nomeAtual;
@property (strong) NSMutableString *valorAtual;

@end

@implementation Categoria

@synthesize _metodo, _instancia, nomeAtual, valorAtual;
@synthesize categorias;

-(void) carregarCategoriasWithCallback: (SEL) _method forInstance: (id) _instance{
    
    _metodo = _method;
    _instancia = _instance;
    
    SoapConnection *soap = [[SoapConnection alloc]initWithSoapAddress:SOAP_ADDRESS targetNamespace:WSDL_TARGET_NAMESPACE operationName:OPERATION_LOGIN parameters:nil headers:nil];
    
    [soap loadServiceWithCallbak:@selector(extrairCategoriasFromXML:) forInstance:self andFailureCallback:nil];
}

-(void) extrairCategoriasFromXML: (NSString *)xml{
    [_instancia performSelectorOnMainThread:_metodo withObject:[self parseXML: xml] waitUntilDone:YES];
}

-(NSArray *)parseXML: (NSString *)xml{
    @try {
        NSData *data = [xml dataUsingEncoding:NSUTF8StringEncoding];
        NSXMLParser *xmlParserConnection = [[NSXMLParser alloc]initWithData:data];
        [xmlParserConnection setDelegate:self];
        categorias = [[NSMutableArray alloc] init];
        [xmlParserConnection parse];
    }
    @catch (NSException *exception) {
        NSLog(@"Parser XML --> %@", exception);
    }
    @finally {
        return categorias;
    }
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    nomeAtual = nil;
    if([elementName rangeOfString:@"category"].length > 0){
        nomeAtual = @"category";
        valorAtual = [[NSMutableString alloc] init];
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if(nomeAtual){
        [valorAtual appendString:string];
    }
}


-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if(nomeAtual){
        [categorias addObject:valorAtual];
        nomeAtual = nil;
    }   
    valorAtual = nil;
}


@end
