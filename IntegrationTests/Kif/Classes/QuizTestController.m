//
//  QuizTestController.m
//  KIF
//
//  Created by Robson Saraiva Ximenes on 06/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QuizTestController.h"

#import "KIFTestScenario+Login.h"

@implementation QuizTestController


- (void)initializeScenarios{
    [self addScenario:[KIFTestScenario scenarioToLogIn]];
}

@end
