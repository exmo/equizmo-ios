//
//  Question.m
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Question.h"

@implementation Question

@synthesize enunciation, answer, playerAnswer, propositions;


- (id) init{
    self = [super init];
    
    self.playerAnswer = -1;
    
    return self;
}


- (BOOL) isItRight{
    return [[NSNumber numberWithInt:answer] isEqualToNumber:[NSNumber numberWithInt:playerAnswer]];
}

@end
