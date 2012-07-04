//
//  Categoria.h
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 29/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Categoria : NSObject<NSXMLParserDelegate>{
    NSMutableDictionary *dicionario;
}

@property NSMutableArray *categorias;

-(void) carregarCategoriasWithCallback: (SEL) _method forInstance: (id) _instance;

@end
