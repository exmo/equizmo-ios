//
//  LocalizedLabel.m
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 09/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocalizedLabel.h"

@implementation LocalizedLabel

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
    NSString* text = NSLocalizedString(self.text, nil);
    [self setText:text];
}

@end
