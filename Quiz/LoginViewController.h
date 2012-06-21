//
//  LoginViewController.h
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#import "Usuario.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate, CLLocationManagerDelegate>

@property Usuario *usuario;

@property (retain, nonatomic) IBOutlet UITextField *textFieldNome;
@property (retain, nonatomic) IBOutlet UITextField *textFieldEmail;

- (IBAction)entrar:(id)sender;
@end
