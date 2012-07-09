//
//  LocalizedTextField.m
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 09/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocalizedTextField.h"

@implementation LocalizedTextField

- (id)initWithCoder:(NSCoder *)aDecoder {
    NSLog(@"Loading LocalizedButton: initWithCoder");
    if ((self = [super initWithCoder:aDecoder])){
        [self localize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    NSLog(@"Loading LocalizedButton: initWithFrame");
    self = [super initWithFrame:frame];
    if (self) {
        [self localize];
    }
    return self;
}

-(void) localize{
    NSString* placeHolder = NSLocalizedString(self.placeholder, nil);
    [self setPlaceholder:placeHolder];
}

@end
