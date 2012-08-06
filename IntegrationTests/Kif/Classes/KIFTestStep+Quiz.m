//
//  KIFTestStep+Quiz.m
//  KIF
//
//  Created by Robson Saraiva Ximenes on 06/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KIFTestStep+Quiz.h"
#import "AppDelegate.h"
#import "LoginViewController.h"

@implementation KIFTestStep (Quiz)

+ (id)stepToReset{
    return [KIFTestStep stepWithDescription:@"Reset the application state." executionBlock:^(KIFTestStep *step, NSError **error) {
        BOOL successfulReset = YES;
        
        // Do the actual reset for your app. Set successfulReset = NO if it fails.
        
        
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        app.viewController.textFieldName.text = @"";
        app.viewController.textFieldEmail.text = @"";
        
        KIFTestCondition(successfulReset, error, @"Failed to reset the application.");
        
        return KIFTestStepResultSuccess;
    }];
}

@end
