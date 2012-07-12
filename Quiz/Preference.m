//
//  Preference.m
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 11/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Preference.h"

@implementation Preference

@synthesize isSoundEnabled, rankingSize;



-(void) save{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool: isSoundEnabled forKey:PREFS_SOUND_ENABLED];
    [defaults setInteger:rankingSize forKey:PREFS_RANKING_SIZE];
    [defaults synchronize];
}

+(Preference *) load{
    Preference *instance = [[Preference alloc] init];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([[NSUserDefaults standardUserDefaults] objectForKey:PREFS_SOUND_ENABLED] != nil){
        instance.isSoundEnabled = [defaults boolForKey:PREFS_SOUND_ENABLED];
    }else {
        instance.isSoundEnabled = YES;
    }
    if([[NSUserDefaults standardUserDefaults] objectForKey:PREFS_RANKING_SIZE] != nil){
        instance.rankingSize = [defaults integerForKey:PREFS_RANKING_SIZE];
    }else {
        instance.rankingSize = 5;
    }
    return instance;
}


@end
