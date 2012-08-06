//
//  KIFTestScenario+Login.m
//  KIF
//
//  Created by Robson Saraiva Ximenes on 06/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KIFTestScenario+Login.h"
#import "KIFTestStep.h"
#import "KIFTestStep+Quiz.h"

@implementation KIFTestScenario (Login)


+ (id)scenarioToLogIn;
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test that a user can successfully log in."];
    [scenario addStep:[KIFTestStep stepToReset]];
    
    [scenario addStep:[KIFTestStep stepToEnterText:@"Integration Tests" intoViewWithAccessibilityLabel:@"User name"]];
    [scenario addStep:[KIFTestStep stepToEnterText:@"integration@test.kif" intoViewWithAccessibilityLabel:@"E-mail"]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Enter"]];
    
    // Verify that the login succeeded
    [scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:@"Ranking"]];
    
    return scenario;
}

@end
