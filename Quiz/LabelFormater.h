//
//  LabelFormater.h
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 04/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LabelFormater : NSObject

+(void) resizeFontToFitLabel: (UILabel *) label maxSize:(float) max minSize:(float) min;
@end
