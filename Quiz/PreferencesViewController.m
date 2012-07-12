//
//  PreferencesViewController.m
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 11/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PreferencesViewController.h"
#import "Preference.h"
#import "PreferencesSwichtCell.h"
#import "PreferencesStepperCell.h"

#define INDEX_SOUND_ENABLED 0
#define INDEX_RANKING 1

@interface PreferencesViewController (){
    Preference *preference;
}

@property Preference *preference;
@property PreferencesSwichtCell *isSoundEnabledCell;
@property PreferencesStepperCell *rankingCell;

@end

@implementation PreferencesViewController

@synthesize preference;

@synthesize isSoundEnabledCell, rankingCell;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        preference = [Preference load];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PreferencesSwichtCell" owner:self options:NULL];
    isSoundEnabledCell = (PreferencesSwichtCell *) [nib objectAtIndex:0];
    isSoundEnabledCell.label.text = @"Sound enabled";
    [isSoundEnabledCell.switcher setOn:preference.isSoundEnabled];
    [isSoundEnabledCell.switcher addTarget:self action:@selector(preferencesDidChange:) forControlEvents:UIControlEventValueChanged];
    
    
    nib = [[NSBundle mainBundle] loadNibNamed:@"PreferencesStepperCell" owner:self options:NULL];
    rankingCell = (PreferencesStepperCell *) [nib objectAtIndex:0];
    rankingCell.label.text = @"Size of ranking";
    rankingCell.stepper.value = preference.rankingSize;
    rankingCell.value.text = [NSString stringWithFormat:@"%.f", rankingCell.stepper.value];
    
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
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"preferencesCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14.0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    

    if(indexPath.row==INDEX_SOUND_ENABLED){
        cell = isSoundEnabledCell;
    }
    
    if(indexPath.row==INDEX_RANKING){
        cell = rankingCell;
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
    [self savePreferences];
    [self dismissModalViewControllerAnimated:YES];
}


#pragma mark Preference events

- (void) preferencesDidChange:(id)sender {
    [self savePreferences];
}

- (void) savePreferences{
    preference.isSoundEnabled = isSoundEnabledCell.switcher.on;
    preference.rankingSize = [rankingCell.value.text intValue];
    [preference save];   
}

@end
