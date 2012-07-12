//
//  PreferencesStepperCell.h
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 12/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreferencesStepperCell : UITableViewCell
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *label;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *value;
@property (unsafe_unretained, nonatomic) IBOutlet UIStepper *stepper;

- (IBAction)stepperValueChanged:(id)sender;

@end
