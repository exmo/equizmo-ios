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
//-(void)habilitarTela: (BOOL) habilita;

@end

@implementation LoginViewController
@synthesize textFieldNome;
@synthesize textFieldEmail;
@synthesize botaoLogar;
@synthesize usuario;


#pragma mark ViewController Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];
    
    // Pega os dados do último acesso local.
    usuario = [Usuario sharedInstance];
    textFieldNome.text = usuario.nome;
    textFieldEmail.text = usuario.email;

    // Configurando o locationManager para obter as coordenadas do usuário
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = 1.0;
    [locationManager startUpdatingLocation];

    // Registra os obeservadores para esta classe.
    [self configurarObservadores];
}

/* Se está iniciando a exibição da tela, ou é a primeira entrada ou está voltando para ela.*/
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"Tela de login");
    [self habilitarTela: YES];
}


- (void)viewDidUnload
{
    [self setTextFieldNome:nil];
    [self setTextFieldEmail:nil];
    [self setBotaoLogar:nil];
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
    [self habilitarTela:NO];
    usuario.nome = textFieldNome.text;
    usuario.email = textFieldEmail.text;
    [usuario logar];
}

#pragma mark Métodos auxiliares

/* Desabilita os campos da tela para evitar cliques indesejáveis. */
- (void) habilitarTela: (BOOL) habilita{
    [botaoLogar setEnabled:habilita];
    [textFieldNome setEnabled:habilita];
    [textFieldEmail setEnabled:habilita];
}


#pragma mark NotificationCenter - listeners

/* Registra todos os observadores desta classe */
-(void) configurarObservadores{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(usuarioSeLogou:) name:EVENTO_LOGIN_OK object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(erroDeConexao:) name:EVENTO_LOGIN_FAIL object:nil];
    
}

-(void) erroDeConexao: (NSNotification *) notification{
    UIAlertView *alert = [[UIAlertView alloc] init];
    alert.title = NSLocalizedString(@"LOGIN_FALHOU",nil);;
    [alert addButtonWithTitle:NSLocalizedString(@"OK",nil)];
    [alert show];
    
    [self habilitarTela:YES];
}

- (void) usuarioSeLogou: (NSNotification *) notification{
    NSLog(@"Usuario logado: %@", [(Usuario *)notification.object email]);
    RankingViewController *ranking = [[RankingViewController alloc] init];
    [botaoLogar setEnabled:YES];
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
    usuario.localizacao = newLocation;
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
