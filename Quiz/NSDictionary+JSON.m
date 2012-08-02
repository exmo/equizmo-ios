//
//  NSDictionary+JSON.m
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 04/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSDictionary+JSON.h"

@implementation NSDictionary (JSON)


+ (NSData *)dataWithContentsOfURLAddress:(NSString *)urlAddress {
    NSData* data = [NSData dataWithContentsOfURL:
                    [NSURL URLWithString: urlAddress] ];
    return data;
}

+(NSDictionary*)dictionaryWithContentsOfJSONURLString: (NSString *)urlAddress{
   
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
    
    NSData *data = [self dataWithContentsOfURLAddress:urlAddress];
    
    app.networkActivityIndicatorVisible = NO;
    
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
