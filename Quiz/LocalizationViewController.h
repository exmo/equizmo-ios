//
//  LocalizationViewController.h
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 12/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface LocalizationViewController : UIViewController<MKMapViewDelegate>

@property (unsafe_unretained, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)close:(id)sender;

@end
