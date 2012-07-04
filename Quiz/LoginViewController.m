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
@synthesize textFieldNome;
@synthesize textFieldEmail;
@synthesize usuario;


#pragma mark ViewController Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];

    
	// Do any additional setup after loading the view, typically from a nib.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    usuario = [[Usuario alloc] init];
    usuario.nome = [defaults objectForKey:VAR_NOME];
    usuario.email = [defaults objectForKey:VAR_EMAIL];
    
    textFieldNome.text = usuario.nome;
    textFieldEmail.text = usuario.email;
    
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    // This is the most important property to set for the manager. It ultimately determines how the manager will
    // attempt to acquire location and thus, the amount of power that will be consumed.
    locationManager.desiredAccuracy = 1.0;
    // Once configured, the location manager must be "started".
    [locationManager startUpdatingLocation];


    
}

- (void)viewDidUnload
{
    [self setTextFieldNome:nil];
    [self setTextFieldEmail:nil];
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
- (IBAction)entrar:(id)sender {
    
    usuario.nome = textFieldNome.text;
    usuario.email = textFieldEmail.text;
    
    [usuario saveAsCurrent];
    
    NSLog(@"Entrando com o usuário: %@ (%@)", usuario.nome, usuario.email);
    
    [usuario logarWithCallback: @selector(usuarioSeLogou:) forInstance:self];
    
}

- (void) usuarioSeLogou: (NSString *) xml{
    NSLog(@"Usuario se logou: ]n%@", xml);
    
    //<return>1661</return>
    NSRange range1 = [xml rangeOfString:@"<return>"];
    NSRange range2 = [xml rangeOfString:@"</return>"];
    
    int p1 = range1.location+range1.length;
    int p2 = range2.location - p1;
    NSString *pontuacaoAtual = [xml substringWithRange:NSMakeRange(p1,p2)];
    
    NSLog(@"Pontuação atual: %@", pontuacaoAtual);
    
    usuario.pontos = [pontuacaoAtual doubleValue]; 
    
    
    NSLog(@"Pontuação atual: %f", usuario.pontos);
    
    
    [usuario saveAsCurrent];
    
    RankingViewController *ranking = [[RankingViewController alloc] init];
    
    [self presentModalViewController:ranking animated:YES];
}


#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation{
    
    usuario.localizacao = newLocation;
    
    NSLog(@"LATITUDE: %f", usuario.localizacao.coordinate.latitude);
    NSLog(@"LONGITUDE: %f", usuario.localizacao.coordinate.longitude);
    
    // Quando pegar desliga!!!    
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
