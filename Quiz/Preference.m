//
//  Preference.m
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 11/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Preference.h"

@implementation Preference

@synthesize isSoundEnabled;



-(void) save{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool: isSoundEnabled forKey:PREFS_SOUND_ENABLED];
    [defaults synchronize];
}

-(void) load{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"PREFS_SOUND_ENABLED"] != nil){
        isSoundEnabled = [defaults boolForKey:PREFS_SOUND_ENABLED];
    }else {
        isSoundEnabled = YES;
    }
}


@end
