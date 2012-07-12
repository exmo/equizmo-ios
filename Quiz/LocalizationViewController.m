//
//  LocalizationViewController.m
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 12/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocalizationViewController.h"
#import "Ranking.h"
#import "User.h"
#import "UserAnnotation.h"

#import <QuartzCore/QuartzCore.h>

#define METERS_PER_MILE 1609.344

@interface LocalizationViewController ()

@end

@implementation LocalizationViewController
@synthesize mapView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {  
    
    [super viewWillAppear:animated];
    
    User *currentUser = [User sharedInstance];
    
    CLLocationCoordinate2D userLocation;
    userLocation.latitude = currentUser.latitude;
    userLocation.longitude= currentUser.longitude;
    
    // Vila mariana: -12.989103, -38.446289
//    userLocation.latitude = -12.989103;
//    userLocation.longitude= -38.446289;

    
    NSLog(@"User location: LAT %f LONG %f", userLocation.latitude, userLocation.longitude);

    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(userLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);

    MKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion];                

    [mapView setRegion:adjustedRegion animated:YES];
    
    
    NSArray *data = [Ranking firsts:100];
    
    for (User * userRanking in data) {        
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = userRanking.latitude;
        coordinate.longitude = userRanking.longitude; 
        UserAnnotation *annotation = [[UserAnnotation alloc] initWithName:userRanking.name score:userRanking.points coordinate:coordinate];
        [mapView addAnnotation:annotation];    
    }
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];
    
    self.mapView.layer.cornerRadius = 10;
    self.mapView.layer.masksToBounds = YES;
    self.mapView.layer.borderWidth = 3.0f;
    self.mapView.layer.borderColor = [UIColor orangeColor].CGColor;
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark MKViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)_mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    static NSString *identifier = @"MyLocation";   
    if ([annotation isKindOfClass:[UserAnnotation class]]) {
        
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        } else {
            annotationView.annotation = annotation;
        }
        
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        annotationView.image=[UIImage imageNamed:@"snowman.png"];//here we use a nice image instead of the default pins
        
        return annotationView;
    }
    
    return nil;    
}


#pragma mark Events

- (IBAction)close:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
