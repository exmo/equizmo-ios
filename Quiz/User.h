//
//  User.h
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface User : NSObject


@property(retain, nonatomic) NSString *name;
@property(retain, nonatomic) NSString *email;
@property(retain, nonatomic) CLLocation *location;
@property double points;

-(void) saveAsCurrent;
-(void) loadCurrent;

+ (User *)sharedInstance;
- (void) login;

@end
