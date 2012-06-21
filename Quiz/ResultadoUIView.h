//
//  ResultadoViewController.h
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 20/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultadoUIView : UIView
@property (unsafe_unretained, nonatomic) IBOutlet ResultadoUIView *view;
@property (retain, nonatomic) IBOutlet UITableView *tabela;
@property (retain, nonatomic) IBOutlet UILabel *labelResultado;

- (IBAction)fechar:(id)sender;
@end
