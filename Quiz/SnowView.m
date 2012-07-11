//
//  SnowView.m
//  Quiz
//
//  http://www.raywenderlich.com/6063/uikit-particle-systems-in-ios-5-tutorial
//

#import "SnowView.h"

#import <QuartzCore/QuartzCore.h>

@implementation SnowView
{
    CAEmitterLayer* snowEmitter; //1
}

-(void)awakeFromNib
{
    //set ref to the layer
    snowEmitter = (CAEmitterLayer*)self.layer; //2
    
    //configure the emitter layer
    snowEmitter.emitterPosition = CGPointMake(self.frame.size.width/2, 0);
//    snowEmitter.emitterSize = CGSizeMake(10, 10);
    snowEmitter.renderMode = kCAEmitterLayerAdditive;
    
    CAEmitterCell* snow = [CAEmitterCell emitterCell];

    snow.emissionLongitude = M_PI / 2;
	snow.emissionLatitude = 200;
	snow.lifetime = 1.5;
	snow.birthRate = 2;
	snow.velocity = 450;
	snow.velocityRange = 50;
	snow.yAcceleration = -250;
	snow.emissionRange = M_PI / 3;
    
    snow.color = [[UIColor colorWithRed:0.2 green:0.1 blue:0.2 alpha:0.5] 
                  CGColor];
    snow.contents = (id)[[UIImage imageNamed:@"snow.png"] CGImage];
    
    snow.scaleSpeed = 0.5;
    snow.spin = 0.8;
    
    [snow setName:@"snow"];
    
    //add the cell to the layer and we're done
    snowEmitter.emitterCells = [NSArray arrayWithObject:snow];
    
    
}

+ (Class) layerClass //3
{
    //configure the UIView to have emitter layer
    return [CAEmitterLayer class];
}

@end
