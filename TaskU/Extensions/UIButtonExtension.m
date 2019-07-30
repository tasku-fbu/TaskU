//
//  UIButtonExtension.m
//  TaskU
//
//  Created by panzaldo on 7/29/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "UIButtonExtension.h"

@interface UIButton ()


@end

@implementation UIButtonExtension

-(void)createFloatingActionButton{
    self.layer.shadowColor = [UIColor grayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 10);
    self.layer.shadowOpacity = 0.25;
    self.layer.shadowRadius = 5;
}



@end
