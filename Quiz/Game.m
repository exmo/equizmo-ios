//
//  Game.m
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Game.h"
#import "User.h"
#import "NSDictionary+JSON.h"

#define REST_ADDRESS_GET_QUIZ @"http://quiz-exmo.rhcloud.com/rest/quiz/get/%@"
#define REST_ADDRESS_ADD_POINTS @"http://quiz-exmo.rhcloud.com/rest/user/addPoints/%@/%i"


@implementation Game

@synthesize questions, category;

- (void) loadQuestions{
    NSLog(@"Preparing questions for %@ category.", category);    
    
    NSDictionary *result = [NSDictionary dictionaryWithContentsOfJSONURLString: [NSString stringWithFormat: REST_ADDRESS_GET_QUIZ, category]];
    
    NSArray *questionsArray = [result objectForKey:@"questions"];
    NSMutableArray *tempQuestionsArray = [[NSMutableArray alloc] init]; 
    for (NSDictionary *question in questionsArray) {
        Question *q = [[Question alloc]init];
        q.enunciation = [question objectForKey:@"enunciation"];
        q.answer = [[question objectForKey:@"answer"] intValue];
        NSMutableArray *propositionsList = [[NSMutableArray alloc] init]; 
        NSArray *propositions = [question objectForKey:@"propositions"];
        for (NSString *proposition in propositions) {
            [propositionsList addObject:proposition];
        }
        q.propositions = propositionsList;
        [tempQuestionsArray addObject:q];
    }
    questions = tempQuestionsArray;
}

- (int) sendScore{
    
    User *user = [User sharedInstance];
    int score = [self calculateScore];

    NSString *URL = [NSString stringWithFormat: REST_ADDRESS_ADD_POINTS, user.email, score];
    NSDictionary *result = [NSDictionary dictionaryWithContentsOfJSONURLString:URL];
    
    int finalScore = [[result objectForKey:@"points"] intValue];
    NSLog(@"Sending points %i, total %i", score, finalScore);
    
    return finalScore;
}

- (double) calculateScore{
    double total = 0;
    for (Question *q in questions) {
        if([q isItRight]){
            total += 120;
        }
    }
    return total;
}

@end
