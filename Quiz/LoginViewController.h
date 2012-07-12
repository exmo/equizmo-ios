//
//  LoginViewController.h
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "User.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate, CLLocationManagerDelegate>

@property User *user;
@property (unsafe_unretained, nonatomic) IBOutlet UIActivityIndicatorView *activity;

@property (retain, nonatomic) IBOutlet UITextField *textFieldName;
@property (retain, nonatomic) IBOutlet UITextField *textFieldEmail;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *buttonLogin;

- (IBAction)login:(id)sender;

- (void) userDidLoggedIn: (NSNotification *) notification;

@end
