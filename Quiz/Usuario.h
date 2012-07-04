//
//  Usuario.h
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface Usuario : NSObject

@property(retain, nonatomic) NSString *nome;
@property(retain, nonatomic) NSString *email;
@property(retain, nonatomic) CLLocation *localizacao;
@property double pontos;

-(void) saveAsCurrent;
-(void) loadCurrent;

- (void) logarWithCallback: (SEL) _method forInstance: (id) _instance;

@end
