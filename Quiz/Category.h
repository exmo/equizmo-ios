//
//  Category.h
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 29/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Category : NSObject<NSXMLParserDelegate>{

}

@property NSMutableArray *categories;

-(void) loadCategoriesWithCallback: (SEL) method forInstance: (id) instance;

@end
