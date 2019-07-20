//
//  DetailsStatusViewController.h
//  TaskU
//
//  Created by lucyyyw on 7/17/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CancelRequestOnDetailsDelegate;

@interface DetailsStatusViewController : UIViewController

@property (strong, nonatomic) Task *task;
@property (strong, nonatomic) id<CancelRequestOnDetailsDelegate> delegate;

@end
@protocol CancelRequestOnDetailsDelegate

-(void) didCancelRequest;

@end

NS_ASSUME_NONNULL_END
