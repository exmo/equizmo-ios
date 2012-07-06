//
//  Question.h
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Question : NSObject

@property NSString *enunciation;
@property int answer;
@property int playerAnswer;
@property NSArray *propositions;

- (BOOL) isItRight;

@end
