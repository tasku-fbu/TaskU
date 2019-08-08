//
//  CustomRefreshControl.h
//  TaskU
//
//  Created by panzaldo on 8/6/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomRefreshControl : UIView

//The path defining the shape to be rendered
@property (strong, nonatomic) CAShapeLayer *progressLayer;
@property (strong, nonatomic) CAShapeLayer *trackLayer;
-(void)createCircularPath;
-(void)setProgressWithAnimation:(NSTimeInterval)interval withValue:(CGFloat)value;
-(void)addCheckImage;


@end

NS_ASSUME_NONNULL_END
