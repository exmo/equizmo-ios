//
//  Game.h
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"

@interface Game : NSObject

@property NSString *category;
@property NSArray *questions;

- (void) loadQuestions;
- (double) calculateScore;
- (int) sendScore;

@end
