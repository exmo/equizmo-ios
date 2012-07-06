//
//  JogoViewController.h
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"
#import <AVFoundation/AVFoundation.h>

@interface GameViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    AVAudioPlayer *playerCerto;
    AVAudioPlayer *playerErrado;
}
@property (unsafe_unretained, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@property (retain, nonatomic) IBOutlet UILabel *labelCategory;
@property (retain, nonatomic) IBOutlet UILabel *labelName;
@property (retain, nonatomic) IBOutlet UILabel *labelPoints;
@property (retain, nonatomic) IBOutlet UILabel *labelIndexOfQuestion;
@property (retain, nonatomic) IBOutlet UILabel *labelNumberOfQuestions;
@property (retain, nonatomic) IBOutlet UILabel *labelEnunciation;
@property (retain, nonatomic) IBOutlet UITableView *tableAnswers;
@property (retain, nonatomic) IBOutlet UIView *viewQuestionsAndPropositions;
@property (retain, nonatomic) IBOutlet UIView *viewScore;
@property (strong, nonatomic) IBOutlet UIView *viewResult;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *totalPoints;

@property NSString *category;

@property Game *game;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *labelFinalScore;

@property UIViewController *mainModal;
- (IBAction)fechar:(id)sender;

@end
