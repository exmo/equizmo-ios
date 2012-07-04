//
//  NSDictionary+JSON.m
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 04/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSDictionary+JSON.h"

@implementation NSDictionary (JSON)


+(NSDictionary*)dictionaryWithContentsOfJSONURLString: (NSString *)urlAddress{
    NSData* data = [NSData dataWithContentsOfURL:
                    [NSURL URLWithString: urlAddress] ];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data
                                                options:kNilOptions error:&error];    
    if (error != nil) return nil;
    
    return result;
}

-(NSData*)toJSON{
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self
                                                options:kNilOptions error:&error];
   
    if (error != nil) return nil;
    return result;   
}


@end
