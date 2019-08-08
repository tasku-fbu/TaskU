//
//  CustomRefreshControl.m
//  TaskU
//
//  Created by panzaldo on 8/6/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "CustomRefreshControl.h"
#include <math.h>
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
        [self initCheckImage];
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
        [self initCheckImage];

        
    }
    return self;
}


-(void)createCircularPath{

    self.backgroundColor = [UIColor clearColor];
    self.layer.cornerRadius = self.frame.size.width/2;


    //Creates and returns a new UIBezierPath object initialized with an arc of a circle
   // Y-Axis is reversed compared to standard coordinate system in math

    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2,   self.frame.size.height/2) radius:(self.frame.size.width-1.5)/2 startAngle:-0.5 * M_PI endAngle:1.5 * M_PI clockwise:YES];

    //Track Layer
    self.trackLayer.path = circlePath.CGPath;
    self.trackLayer.fillColor = [[UIColor clearColor] CGColor];
    self.trackLayer.strokeColor = [[UIColor lightGrayColor] CGColor];
    self.trackLayer.lineWidth = 10.0;
    self.trackLayer.strokeEnd = 1.0;  //Relative location at which to stop stroking the path


    //Add trackLayer as a sublayer
    [self.layer addSublayer:self.trackLayer];

    
    //Progress Layer
    self.progressLayer.path = circlePath.CGPath;
    self.progressLayer.fillColor = [[UIColor clearColor] CGColor];
    self.progressLayer.strokeColor = [[UIColor blueColor] CGColor];
    self.progressLayer.lineWidth = 10.0;
    self.progressLayer.strokeEnd = 0.0;


    //Add progressLayer as a sublayer
    [self.layer addSublayer:self.progressLayer];
    
  
}


-(void) setProgressWithAnimation:(NSTimeInterval)duration withValue:(CGFloat)value{

    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.repeatCount = FLT_MAX;
    animation.keyPath = @"strokeEnd";
    
    animation.duration = duration;
    animation.fromValue = 0;
    animation.toValue =  [NSNumber numberWithDouble:value];

    // Defines the pacing of the animation (ocurs evenly)
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    self.progressLayer.strokeEnd = value;
    
    [self.progressLayer addAnimation:animation forKey:@"animateprogress"];
    
    
}

-(void)initCheckImage{
    image = [UIImage imageNamed:@"check"];
    imageView = [[UIImageView alloc] initWithImage:image];
    imageView.center = self.center;
    [imageView setFrame:CGRectMake(20, 20, 60, 60)];
    [self addSubview:imageView];
    [imageView setHidden:YES];
}

-(void)addCheckImage{
     [imageView setHidden:NO];
}
//
//
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    UIBezierPath
//
//}


@end
