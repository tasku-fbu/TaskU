//
//  CustomRefreshControl.m
//  TaskU
//
//  Created by panzaldo on 8/6/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "CustomRefreshControl.h"
#include <math.h>

//This is the CustomRefreshControl you want to use!
@implementation CustomRefreshControl
{
    UIImage *image;
    UIImageView *imageView;
}


//Override the two default initializers that are inherent to UIView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.progressLayer = [[CAShapeLayer alloc] init];
        self.trackLayer = [[CAShapeLayer alloc] init];
        [self createCircularPath];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.progressLayer = [[CAShapeLayer alloc] init];
        self.trackLayer = [[CAShapeLayer alloc] init];
        [self createCircularPath];
    }
    return self;
}


-(void)createCircularPath{

    self.backgroundColor = [UIColor clearColor];
    self.layer.cornerRadius = self.frame.size.width/2;


    //Creates and returns a new UIBezierPath object initialized with an arc of a circle
   // Y-Axis is reversed compared to standard coordinate system in math

    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2,   self.frame.size.height/2) radius:(self.frame.size.width-3)/2 startAngle:-0.5 * M_PI endAngle:1.5 * M_PI clockwise:YES];

    //Track Layer
    self.trackLayer.path = circlePath.CGPath;
    self.trackLayer.fillColor = [[UIColor clearColor] CGColor];
    self.trackLayer.strokeColor = [[UIColor whiteColor] CGColor];
    self.trackLayer.lineWidth = 10.0;
    self.trackLayer.strokeEnd = 1.0;  //Relative location at which to stop stroking the path

    //Add trackLayer as a sublayer
    [self.layer addSublayer:self.trackLayer];
    
    //Progress Layer
    self.progressLayer.path = circlePath.CGPath;
    self.progressLayer.fillColor = [[UIColor clearColor] CGColor];
    self.progressLayer.strokeColor = [[UIColor colorNamed:@"blue"] CGColor];
    self.progressLayer.lineWidth = 10.0;
    self.progressLayer.strokeEnd = 0.0;

    //Add progressLayer as a sublayer
    [self.layer addSublayer:self.progressLayer];
}

/*
Creates animation for the stroke loading
 params:
 duration - the duration of the animation
 value - what percentage of the arc is filled (we want 100%)
*/
-(void) setProgressWithAnimation:(NSTimeInterval)duration withValue:(CGFloat)value{

    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"strokeEnd";
    
    animation.duration = duration;
    //Starting and ending point
    animation.fromValue = 0;
    animation.toValue =  [NSNumber numberWithDouble:value];
    
    // Defines the pacing of the animation (ocurs evenly)
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    //Repeats animation infinitely
    animation.repeatDuration =  FLT_MAX;
    
    [self.progressLayer addAnimation:animation forKey:@"animateprogress"];
    [self initCheckImage];
    
    
}
/*
 Initializes our logo image to be in the center of circle
 Image will be hidden until data has loaded
 */
-(void)initCheckImage{
    image = [UIImage imageNamed:@"check-1"];
    imageView = [[UIImageView alloc] initWithImage:image];
    imageView.center = self.center;
    [imageView setFrame:CGRectMake(20, 20, 60, 60)];
    [self addSubview:imageView];
    //[imageView setHidden:YES];
}


-(void)addCheckImage{
     [imageView setHidden:NO];
    
}

@end
