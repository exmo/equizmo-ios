//
//  JogoViewController.m
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JogoViewController.h"
#import "Questao.h"
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>
#import "LabelFormater.h"
#import "Usuario.h"

@interface JogoViewController (){
    int indiceQuestaoAtual;
    NSArray *letras;
}

@end

@implementation JogoViewController
@synthesize labelCategoria;
@synthesize labelNome;
@synthesize labelPontos;
@synthesize labelNumeroDaPergunta;
@synthesize labelTotalDePerguntas;
@synthesize labelTempoDaResposta;
@synthesize labelPergunta;
@synthesize tabelaRespostas;
@synthesize viewPerguntaRespostas;
@synthesize viewPontuacao;
@synthesize resultadoView;
@synthesize totalPontos;

@synthesize labelPontuacaoFinal;
@synthesize tabelaResultadoFinal;
@synthesize mainModal;

@synthesize jogo, categoria;


#pragma mark LifeCycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];
    
    viewPontuacao.layer.cornerRadius = 10;
    viewPontuacao.layer.masksToBounds = YES;
    viewPontuacao.layer.borderWidth = 3.0f;
    viewPontuacao.layer.borderColor = [UIColor orangeColor].CGColor; 
    
    viewPerguntaRespostas.layer.cornerRadius = 10;
    viewPerguntaRespostas.layer.masksToBounds = YES;
    viewPerguntaRespostas.layer.borderWidth = 3.0f;
    viewPerguntaRespostas.layer.borderColor = [UIColor whiteColor].CGColor;
    
    indiceQuestaoAtual = -1;
    
    letras = [NSArray arrayWithObjects:@"a",@"b",@"c",@"d",@"e",@"f",@"g", nil];
    
    
    //Preparar os tocadores para não ter delay
    NSURL *url1 = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/success.mp3",[[NSBundle mainBundle] resourcePath]]];
    NSURL *url2 = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/fail.mp3",[[NSBundle mainBundle] resourcePath]]];
    playerCerto = [[AVAudioPlayer alloc] initWithContentsOfURL:url1 error:nil];
    playerErrado = [[AVAudioPlayer alloc] initWithContentsOfURL:url2 error:nil];
    [playerCerto prepareToPlay];
    [playerErrado prepareToPlay];    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    labelNome.text = [defaults objectForKey:@"nome"];

    jogo = [[Jogo alloc] init];
    jogo.categoria = categoria;
    
    [jogo prepararQuestoes];
    
    labelCategoria.text = categoria;
    labelTotalDePerguntas.text = [NSString stringWithFormat:@"%d", [jogo.questoes count]];
    
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self exibirProximaQuestao];
}

- (void)viewDidUnload
{
    [self setLabelCategoria:nil];
    [self setLabelNome:nil];
    [self setLabelPontos:nil];
    [self setLabelNumeroDaPergunta:nil];
    [self setLabelTotalDePerguntas:nil];
    [self setLabelTempoDaResposta:nil];
    [self setLabelPergunta:nil];
    [self setTabelaRespostas:nil];
    [self setViewPerguntaRespostas:nil];
    [self setViewPontuacao:nil];
    [self setResultadoView:nil];
    [self setLabelPontuacaoFinal:nil];
    [self setTabelaRespostas:nil];
    [self setTabelaResultadoFinal:nil];
    [self setTotalPontos:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView == tabelaResultadoFinal){
        // Ultimo resultado
        if(indexPath.row == ([jogo.questoes count]-1)){
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
            NSString *pontuacao = [formatter stringFromNumber:[NSNumber numberWithDouble:[jogo pontuacao]]];
            labelPontuacaoFinal.text =[NSString stringWithFormat:@"%@ pontos!",  pontuacao];
            
            [labelPontuacaoFinal setHidden:NO];
        }else{
            NSDate *future = [NSDate dateWithTimeIntervalSinceNow: 0.8 ];
            [NSThread sleepUntilDate:future];
        }
    }
    
}

#pragma mark UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(indiceQuestaoAtual<0)
        return 0;
    
    if(tableView == tabelaResultadoFinal){
        return [jogo.questoes count];
    }

    
    Questao *q = [jogo.questoes objectAtIndex:indiceQuestaoAtual];
    return [q.proposicoes count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == tabelaResultadoFinal){
        static NSString * cellIdResultado = @"CelulaResultado";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdResultado];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdResultado];
        }
        Questao *q = [jogo.questoes objectAtIndex:indexPath.row];
        cell.textLabel.text = q.pergunta;
        cell.textLabel.font = [UIFont boldSystemFontOfSize:15.0];
        cell.textLabel.textColor = [UIColor whiteColor];
        [cell.textLabel sizeToFit];
//        [self resizeFontToFitLabel: cell.textLabel];
        
        cell.detailTextLabel.text = [q.proposicoes objectAtIndex:q.respostaJogador];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0];
        cell.detailTextLabel.textColor = [UIColor whiteColor];
        [cell.detailTextLabel sizeToFit];
//        [self resizeFontToFitLabel: cell.detailTextLabel];
        
        if([q estaCerto]){
            cell.imageView.image = [UIImage imageNamed:@"penguim"];
        }else {
            cell.imageView.image = [UIImage imageNamed:@"sid"];
        }
        
        return cell;
    }
    
    
    static NSString * cellId = @"CelularProposicao";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    Questao *q = [jogo.questoes objectAtIndex:indiceQuestaoAtual];
    NSString  *letra = [letras objectAtIndex:indexPath.row];
    NSString  *proposicao = [q.proposicoes objectAtIndex:indexPath.row];    
    cell.textLabel.text = [NSString stringWithFormat:@"%@) %@",letra, proposicao];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15.0];
    [LabelFormater resizeFontToFitLabel: cell.textLabel maxSize:15.0 minSize:10.0];
    
    return cell;
}

- (void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indiceQuestaoAtual < [jogo.questoes count]){
        Questao *q = [jogo.questoes objectAtIndex:indiceQuestaoAtual];
        q.respostaJogador = indexPath.row;
        
        if(q.estaCerto){
            [playerErrado stop];
            [playerCerto play]; 
        }else{
            [playerCerto stop];
            [playerErrado play];
        }
        
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        NSString *pontuacao = [formatter stringFromNumber:[NSNumber numberWithDouble:[jogo pontuacao]]];
        labelPontos.text = pontuacao;
        
//        while([playerCerto isPlaying] || [playerErrado isPlaying]){
//            // Espera o infeliz terminar o som!
//        }
        
        [self exibirProximaQuestao];
    }
    
}

#pragma mark Metodos



-(void) exibirProximaQuestao{
    indiceQuestaoAtual++;
    if(indiceQuestaoAtual < [jogo.questoes count]){
        Questao *q = [jogo.questoes objectAtIndex:indiceQuestaoAtual];
        labelPergunta.text =  q.pergunta;
        [LabelFormater resizeFontToFitLabel:labelPergunta maxSize:20.0 minSize:15.0];
        labelNumeroDaPergunta.text = [NSString stringWithFormat:@"%d", indiceQuestaoAtual+1];
        [tabelaRespostas reloadData];
    }else {
        // Envia para o servidor e exibe o resultado;
        
        [self encerrarJogo];
    }
}

- (void) encerrarJogo{
    
    int total = [jogo informarPontuacao];
    
    
    Usuario *u = [[Usuario alloc]init ];
    [u loadCurrent];
    u.pontos = total;
    [u saveAsCurrent];
    
    totalPontos.text = [NSString stringWithFormat:@"%i", total];
    
//    [self.view addSubview:resultadoView];
    
    resultadoView.center = CGPointMake( self.view.frame.size.width/2, self.view.frame.size.height/2);
    resultadoView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.9];
    resultadoView.layer.cornerRadius = 10;
    resultadoView.layer.masksToBounds = YES;
    resultadoView.layer.borderWidth = 3.0f;
    resultadoView.layer.borderColor = [UIColor orangeColor].CGColor; 
    
    
    [UIView transitionWithView:self.view duration:0.8
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^ { 
                        [self.view addSubview:resultadoView]; 
                        [tabelaResultadoFinal reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
                    }
                    completion:nil];
    
}

/* Como estou trabalhando com telas modais, preciso fechar a primeira para que as demais fechem automáticamente
 * Para isso eu utilizo o ViewController da tela anterior e peço a ele para fechar o modal dele.
 */
- (void) fecharJanelas{
    if ([[mainModal parentViewController] respondsToSelector:@selector(dismissModalViewControllerAnimated:)]){
        [[mainModal parentViewController] dismissModalViewControllerAnimated:YES];
    } else {
        [[mainModal presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    }    
    
    [mainModal viewWillAppear:true];
}


- (IBAction)fechar:(id)sender {
    [self fecharJanelas];
}
@end
