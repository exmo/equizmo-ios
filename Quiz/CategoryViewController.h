//
//  SelecionarCategoriaViewController.h
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (unsafe_unretained, nonatomic) IBOutlet UIView *viewCategory;

@property NSArray *categoryList;
@property (unsafe_unretained, nonatomic) IBOutlet UIActivityIndicatorView *activity;

@property UIViewController *mainModel;
@property (unsafe_unretained, nonatomic) IBOutlet UITableView *tableCategory;

- (IBAction)cancel:(id)sender;

@end
