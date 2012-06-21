//
//  SelecionarCategoriaViewController.h
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelecionarCategoriaViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property NSArray *lista;

@property UIViewController *mainModel;

@end
