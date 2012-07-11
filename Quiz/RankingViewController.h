//
//  RankingViewController.h
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RankingViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (retain, nonatomic) IBOutlet UILabel *labelPoints;
@property (retain, nonatomic) IBOutlet UILabel *labelName;
@property (retain, nonatomic) IBOutlet UITableView *table;
@property NSArray *users;

@property (retain, nonatomic) IBOutlet UIView *viewScore;
@property (retain, nonatomic) IBOutlet UIView *viewRanking;

- (IBAction)logout:(id)sender;

- (IBAction)startGame:(id)sender;

- (IBAction)configureAccount:(id)sender;

@end
