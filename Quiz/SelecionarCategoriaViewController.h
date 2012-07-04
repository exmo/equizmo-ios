//
//  SelecionarCategoriaViewController.h
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelecionarCategoriaViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (unsafe_unretained, nonatomic) IBOutlet UIView *viewCategoria;

@property NSArray *lista;
@property (unsafe_unretained, nonatomic) IBOutlet UIActivityIndicatorView *indicadorAtividade;

@property UIViewController *mainModel;
@property (unsafe_unretained, nonatomic) IBOutlet UITableView *tabelaCategorias;

- (IBAction)cancelar:(id)sender;

@end
