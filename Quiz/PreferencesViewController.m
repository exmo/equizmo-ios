//
//  PreferencesViewController.m
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 11/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PreferencesViewController.h"
#import "Preference.h"

@interface PreferencesViewController (){
    Preference *preference;
}

@property Preference *preference;

@end

@implementation PreferencesViewController

@synthesize preference;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        preference = [[Preference alloc] init];
        [preference load];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark UITableViewDataSource
//@required

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"preferencesCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14.0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    

    if(indexPath.row==0){
        UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
        [switchView setOn:preference.isSoundEnabled animated:NO];
        [switchView addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = switchView;
        cell.textLabel.text = @"Sound enabled";
    }
    
    return cell;

}

//@optional

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Preferences";
}

#pragma mark UITableViewDelegate
// Not necessary, for now...


#pragma mark IBAction

- (IBAction)closePreferences:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}


#pragma mark Preference events

- (void) switchChanged:(id)sender {
    UISwitch* switchControl = sender;
    NSLog( @"The switch is %@", switchControl.on ? @"ON" : @"OFF" );
    preference.isSoundEnabled = switchControl.on;
    [preference save];
}
@end
