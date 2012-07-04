//
//  NSDictionary+JSON.h
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 04/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JSON)

+(NSDictionary*)dictionaryWithContentsOfJSONURLString: (NSString*)urlAddress;

-(NSData*) toJSON;

@end
