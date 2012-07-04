//
//  LabelFormater.m
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 04/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LabelFormater.h"

@implementation LabelFormater

+(void) resizeFontToFitLabel: (UILabel *) label maxSize:(float) max minSize:(float) min{
    NSString *theText = label.text;
    CGRect labelRect = label.frame;
    label.adjustsFontSizeToFitWidth = NO;
    label.numberOfLines = 0;
    
    CGFloat fontSize = max;
    while (fontSize >= min)
    {
        CGSize size = [theText sizeWithFont:[UIFont fontWithName:label.font.fontName size:fontSize] constrainedToSize:CGSizeMake(labelRect.size.width, 10000) lineBreakMode:UILineBreakModeWordWrap];
        
        if (size.height <= labelRect.size.height) break;
        fontSize -= 0.5;
    }
    label.font = [UIFont fontWithName:label.font.fontName size:fontSize];
}

@end
