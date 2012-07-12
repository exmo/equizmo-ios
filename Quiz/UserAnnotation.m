//
//  MyLocation.m
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 12/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UserAnnotation.h"

@implementation UserAnnotation
@synthesize name;
@synthesize score;
@synthesize coordinate;

- (id)initWithName:(NSString*)_name score:(double)_score coordinate:(CLLocationCoordinate2D)_coordinate {
    if ((self = [super init])) {
        name = [_name copy];
        score = _score;
        coordinate = _coordinate;
    }
    return self;
}

- (NSString *)title {
    if ([name isKindOfClass:[NSNull class]]) 
        return @"Noname";
    else
        return name;
}

- (NSString *)subtitle {
    NSNumber *newScore = [NSNumber numberWithDouble:score];
    NSString *stringScore = [NSNumberFormatter localizedStringFromNumber:newScore
                                                        numberStyle:NSNumberFormatterDecimalStyle];

    return [NSString stringWithFormat:@"Total: %@", stringScore];
}

@end
