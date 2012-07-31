//
//  UserTest.m
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 31/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UserTest.h"
#import "User.h"

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


@end
