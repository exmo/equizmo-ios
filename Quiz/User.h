//
//  User.h
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface User : NSObject


@property(retain, nonatomic) NSString *name;
@property(retain, nonatomic) NSString *email;
@property double points;
@property float longitude;
@property float latitude;

-(void) saveAsCurrent;
-(void) loadCurrent;

+ (User *)sharedInstance;
- (void) login;

@end
