//
//  Ranking.m
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 04/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Ranking.h"
#import "NSDictionary+JSON.h"
#import "Usuario.h"

#define REST_ADDRESS @"http://quiz-exmo.rhcloud.com/rest/user/ranking/%i"

@implementation Ranking

+ (NSArray *) listarPrimeiros: (int) numero{
    
    NSDictionary *result = [NSDictionary dictionaryWithContentsOfJSONURLString: [NSString stringWithFormat: REST_ADDRESS, numero ]];
    
    NSMutableArray *ranking = [[NSMutableArray alloc]init];
    NSArray *usuarios = [result objectForKey:@"lista"];
    for (NSDictionary *userDic in usuarios) {
        Usuario *u = [[Usuario alloc]init];
        u.email = [userDic objectForKey:@"email"];
        u.nome = [userDic objectForKey:@"name"];
        u.pontos = [[userDic objectForKey:@"points"] doubleValue];

        
        [ranking addObject:u];
    }
    
    return ranking;
}

@end
