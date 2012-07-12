//
//  MyLocation.h
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 12/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MapKit/MapKit.h>

@interface UserAnnotation : NSObject <MKAnnotation> 

@property (copy) NSString *name;
@property double score;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id)initWithName:(NSString*)name score:(double)score coordinate:(CLLocationCoordinate2D)coordinate;

@end
