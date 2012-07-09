//
//  LocalizedButton.m
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 09/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocalizedButton.h"

@implementation LocalizedButton

- (id)initWithCoder:(NSCoder *)aDecoder {
    NSLog(@"Loading LocalizedButton: initWithCoder");
    if ((self = [super initWithCoder:aDecoder])){
        [self localizeButton];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    NSLog(@"Loading LocalizedButton: initWithFrame");
    self = [super initWithFrame:frame];
    if (self) {
       [self localizeButton];
    }
    return self;
}

-(void) localizeButton{
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    NSString* text = NSLocalizedString(self.titleLabel.text, nil);
    [self setTitle:text forState:UIControlStateNormal];
    [self setTitle:text forState:UIControlStateHighlighted];
    [self setTitle:text forState:UIControlStateDisabled];
    [self setTitle:text forState:UIControlStateSelected];
}


@end
