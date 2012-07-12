//
//  PreferencesStepperCell.m
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 12/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PreferencesStepperCell.h"

@implementation PreferencesStepperCell
@synthesize label;
@synthesize value;
@synthesize stepper;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)stepperValueChanged:(id)sender{
    double stepperValue = stepper.value;
    self.value.text = [NSString stringWithFormat:@"%.f", stepperValue];
}

@end
