//
//  LoginViewController.m
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "RankingViewController.h"

@interface LoginViewController (){
    CLLocationManager *locationManager;
}

@end

@implementation LoginViewController
@synthesize textFieldName;
@synthesize textFieldEmail;
@synthesize buttonLogin;
@synthesize user;


#pragma mark ViewController Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];
    
    // Last loged user.
    user = [User sharedInstance];
    textFieldName.text = user.name;
    textFieldEmail.text = user.email;

    // Configurando o locationManager para obter as coordenadas do usuário
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = 1.0;
    [locationManager startUpdatingLocation];

    // Registra os obeservadores para esta classe.
    [self configureTheListeners];
}

/* Se está iniciando a exibição da tela, ou é a primeira entrada ou está voltando para ela.*/
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"Tela de login");
    [self setViewEnabled: YES];
}


- (void)viewDidUnload
{
    [self setTextFieldName:nil];
    [self setTextFieldEmail:nil];
    [self setButtonLogin:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark UBActions

- (IBAction)login:(id)sender {
    [self setViewEnabled:NO];
    user.name = textFieldName.text;
    user.email = textFieldEmail.text;
    [user login];
}

#pragma mark Métodos auxiliares

/* Desabilita os campos da tela para evitar cliques indesejáveis. */
- (void) setViewEnabled: (BOOL) enabled{
    [buttonLogin setEnabled:enabled];
    [textFieldName setEnabled:enabled];
    [textFieldEmail setEnabled:enabled];
}


#pragma mark NotificationCenter - listeners

/* Registra todos os observadores desta classe */
-(void) configureTheListeners{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLoggedIn:) name:EVENT_LOGIN_OK object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLoggedWithError:) name:EVENT_LOGIN_FAIL object:nil];
    
}

-(void) userDidLoggedWithError: (NSNotification *) notification{
    UIAlertView *alert = [[UIAlertView alloc] init];
    alert.title = NSLocalizedString(@"LOGIN_FAILED",nil);;
    [alert addButtonWithTitle:NSLocalizedString(@"OK",nil)];
    [alert show];
    
    [self setViewEnabled:YES];
}

- (void) userDidLoggedIn: (NSNotification *) notification{
    NSLog(@"Usuario logado: %@", [(User *)notification.object email]);
    RankingViewController *ranking = [[RankingViewController alloc] init];
    [buttonLogin setEnabled:YES];
    [self presentModalViewController:ranking animated:YES];
}


#pragma mark CLLocationManagerDelegate

/**
 * Como não precisamos de muita precisão pegamos apenas a primeira localização;
 * Desligamos o GPS logo, pois consome energia desnecessária!    
 */
- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation{
    user.location = newLocation;
    [locationManager stopUpdatingLocation];
    locationManager.delegate = nil;
}


#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
