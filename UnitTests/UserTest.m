//
//  UserTest.m
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 31/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UserTest.h"
#import "User.h"
#import "Constants.h"

@implementation UserTest

- (void)setUp{
    [super setUp];
}

- (void)tearDown{
    [super tearDown];
}

- (void)testSaveAsCurrent{
    NSString *email = @"email";
    NSString *name = @"name";
    float latitude = 1.1;
    float longitude = 2.2;
    
    User *userToSave = [[User alloc] init];
    userToSave.email = email;
    userToSave.name = name;
    userToSave.latitude = latitude;
    userToSave.longitude = longitude;
    
    [userToSave saveAsCurrent];
    
    
    User *current = [User sharedInstance];
    
    STAssertNotNil(current,@"No current user.");
    
    STAssertTrue([email isEqualToString:current.email], @"Expected email as: <%@> but was <%@>", email, current.email);
    STAssertTrue([name isEqualToString:current.name], @"Expected name as: <%@> but was <%@>", email, current.email);
    
    STAssertEquals(latitude, current.latitude,@"Latitude is not equal");
    STAssertEquals(longitude, current.longitude,@"Longitude is not equal");
}

- (void)testIfSharedInstanceReturnsAllwaysTheSameUser{
    
    User *user1 = [User sharedInstance];
    User *user2 = [User sharedInstance];
    User *user3 = [User sharedInstance];
    
    STAssertNotNil(user1,@"No user sharedInstance ");
    STAssertNotNil(user2,@"No user sharedInstance ");
    STAssertNotNil(user3,@"No user sharedInstance ");
    
    STAssertEquals(user1, user2,@"Not the same user.");
    STAssertEquals(user1, user3,@"Not the same user.");
}

/**
 Now we need to mock the SoapConnection that is used by our target test method.
 */
- (void) testloginOK{
    
    User *user = [[User alloc]init];
    user.name = @"User name";
    user.email = @"user@email.com";
    user.longitude = 2.2;
    user.latitude = 1.1;

    /* Mock the notification */
    id mock = [OCMockObject observerMock];
    [[NSNotificationCenter defaultCenter] addMockObserver:mock name:EVENT_LOGIN_OK object:nil];
    [[mock expect] notificationWithName:EVENT_LOGIN_OK object:[OCMArg any] userInfo:[OCMArg any]];
    // Mock Notification prepared
    
    [user login];
    

    
    [[NSNotificationCenter defaultCenter] removeObserver:mock];
    [mock verify];
}

@end
