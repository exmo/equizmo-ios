//
//  Ranking.m
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 04/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Ranking.h"
#import "User.h"
#import "NSDictionary+JSON.h"

#define REST_ADDRESS @"http://quiz-exmo.rhcloud.com/rest/user/ranking/%i"

@implementation Ranking

+ (NSArray *) firsts:(int)offset{
    
    NSDictionary *result = [NSDictionary dictionaryWithContentsOfJSONURLString: [NSString stringWithFormat: REST_ADDRESS, offset ]];
    
    NSMutableArray *firstsArray = [[NSMutableArray alloc]init];
    NSArray *userArray = [result objectForKey:@"users"];
    for (NSDictionary *userDic in userArray) {
        User *u = [[User alloc]init];
        u.email = [userDic objectForKey:@"email"];
        u.name = [userDic objectForKey:@"name"];
        u.points = [[userDic objectForKey:@"points"] doubleValue];
        u.longitude = [[userDic objectForKey:@"longitude"] floatValue];
        u.latitude = [[userDic objectForKey:@"latitude"] floatValue];
        [firstsArray addObject:u];
        NSLog(@"Pontos de %@: %f",u.name,u.points);
    }
    
    return firstsArray;
}

@end
