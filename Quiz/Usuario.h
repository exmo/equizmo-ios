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

@property NSString *nome;
@property NSString *email;
@property CLLocation *localizacao;
@property double pontos;

@end
