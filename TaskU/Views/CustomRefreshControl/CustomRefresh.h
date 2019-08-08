//
//  CustomRefresh.h
//  TaskU
//
//  Created by panzaldo on 8/6/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomRefresh : UIView

@property(strong,nonatomic) CAShapeLayer* foregroundLayer;
@property(strong,nonatomic) CAShapeLayer* backgroundLayer;
@property(strong,nonatomic) UILabel* label;
-(void)setProgress: (double)progressConstant withAnimation:(BOOL)animation;



@end

NS_ASSUME_NONNULL_END
