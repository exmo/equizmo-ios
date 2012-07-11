//
//  Preference.h
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 11/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Preference : NSObject

@property(nonatomic) BOOL isSoundEnabled;

- (void) save;

- (void) load;

@end
