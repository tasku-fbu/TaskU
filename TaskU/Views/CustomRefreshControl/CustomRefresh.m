//
//  CustomRefresh.m
//  TaskU
//
//  Created by panzaldo on 8/6/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "CustomRefresh.h"

@implementation CustomRefresh{
    @private CGFloat lineWidth;
    @private CGFloat labelSize;
    @private int safePercent;
    @private int radius;
    @private CGPoint pathCenter;
    @private bool layoutDone;
}

//Override the two default initializers that are inherent to UIView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundLayer = [[CAShapeLayer alloc] init];
        NSLog(@"asjfdhsjfdsk");
        self.foregroundLayer  = [[CAShapeLayer alloc] init];
        [self customInit];
        [self setupView];
        self.label.text = @"0";
        NSLog(@"Hello initframe");
   
        

    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.backgroundLayer = [[CAShapeLayer alloc] init];
        //NSLog(@"asjfdhsjfdsk");
        self.foregroundLayer  = [[CAShapeLayer alloc] init];
        [self customInit];
        [self setupView];
        self.label.text = @"0";
        NSLog(@"Hello coder");
    }
    return self;
}
/*
-(void)awakeFromNib{
    [super awakeFromNib];
    [self setupView];
    self.label.text = @"0";
}
*/

//Assign values to private variables
-(void)customInit{
    NSLog(@"I reached customInit");
    safePercent = 100;
    lineWidth = 50;
    pathCenter = [self.superview convertPoint:self.center toView:self];
    self.backgroundLayer.lineWidth = lineWidth;
    self.foregroundLayer.lineWidth = lineWidth - (0.20 * lineWidth);
    radius = [self radiusHelper];
  
}

-(void) setForegroundLayerColorForSafePercent{
    if ([self.label.text integerValue] >= 100) {
        self.foregroundLayer.strokeColor = [[UIColor greenColor] CGColor];
    } else {
        self.foregroundLayer.strokeColor = [[UIColor redColor] CGColor];
    }
}

-(int)radiusHelper {
     if (self.frame.size.width < self.frame.size.height){
         return (self.frame.size.width - lineWidth)/2;
         
     } else {
         return (self.frame.size.height - lineWidth)/2;
         
     }
}

-(double)progressHelper:(double)num{
    if(num > 1) return 1;
    else if(num < 0) return 0;
    else { return num;}
    
}

-(void) makeProgressBar{
    self.layer.sublayers = nil;
    [self drawBackgroundLayer];
    [self drawForegroundLayer];
}

//-(void)customInit2{
//    self.label.adjustsFontSizeToFitWidth = YES;
//    self.label.center = [self.superview convertPoint:self.label.center toView:self];
//
//}

-(void)drawBackgroundLayer{
    NSLog(@"I reached drawBackgroundLayer");

    CGFloat angle = 2 * M_PI;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:pathCenter radius:radius startAngle:0 endAngle:angle clockwise:YES];
    
    self.backgroundLayer.path = path.CGPath;
    self.backgroundLayer.fillColor = [[UIColor clearColor] CGColor];
    self.backgroundLayer.strokeColor = [[UIColor brownColor] CGColor];
    self.backgroundLayer.lineWidth = lineWidth - (lineWidth * 20/100);
    
    //Add backgroundLayer as a sublayer
    [self.layer addSublayer:self.backgroundLayer];
}

-(void)drawForegroundLayer{
    CGFloat startAngle = (-M_PI / 2);
    CGFloat endAngle = 2 * M_PI + startAngle;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:pathCenter radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    
    self.foregroundLayer.path = path.CGPath;
    self.foregroundLayer.lineCap = kCALineCapRound;
    
    self.foregroundLayer.lineWidth = lineWidth;

    self.foregroundLayer.fillColor = [[UIColor clearColor] CGColor];
    self.foregroundLayer.strokeColor = [[UIColor redColor] CGColor];
    self.foregroundLayer.strokeEnd = 0;

    //Add backgroundLayer as a sublayer
    [self.layer addSublayer:self.foregroundLayer];
}


-(UILabel*)makeLabel:(NSString*)text{
    self.label.frame = CGRectMake(0, 0, 0, 0);
    self.label.text = text;
    [self.label setFont: [self.label.font fontWithSize: 12]];
    [self.label sizeToFit];
    self.label.center = pathCenter;
    return self.label;
}


-(void)setupView{
    [self makeProgressBar];
    [self addSubview:self.label];
    
}

-(void)configLabel{
    [self.label sizeToFit];
    self.label.center = pathCenter;
}

//Layout Sublayers
-(void)layoutSublayersOfLayer:(CALayer *)layer {
    if(!layoutDone){
        NSString *tempText;
        tempText = self.label.text;
        [self setupView];
        //self.label.text;
        layoutDone = true;
    }
  //  if (layer == self.layer)
 //   {
 //       _anySubLayer.frame = layer.bounds;
 //   }
    
 //   super.layoutSublayersOfLayer(layer)
}

-(void)setProgress: (double)progressConstant withAnimation:(BOOL)animation {
    double progress = [self progressHelper:progressConstant];
    self.foregroundLayer.strokeEnd = (CGFloat)progress;
    
    if(animation){
        CABasicAnimation *basicAnimation = [CABasicAnimation animation];
        basicAnimation.keyPath = @"strokeEnd";
        basicAnimation.fromValue = 0;
        basicAnimation.toValue =  [NSNumber numberWithDouble:progress];
        basicAnimation.duration = 2;
        
        [self.backgroundLayer addAnimation:basicAnimation forKey:@"foregroundAnimation"];
    }
    
    __block double currentTime = 0;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.05 repeats:YES block:^(NSTimer * _Nonnull timer) {
        if(currentTime >= 2){
            [timer invalidate];
        } else{
            currentTime += 0.05;
            self.label.text = @"progress";
            [self setForegroundLayerColorForSafePercent];
            [self configLabel];
        }
    }];
    [timer fire];
}
 

@end
