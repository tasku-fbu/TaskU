//
//  DetailsStatusViewController.h
//  TaskU
//
//  Created by lucyyyw on 7/17/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "LocationsViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CancelRequestOnDetailsDelegate;
@protocol CancelMissionOnDetailsDelegate;

@interface DetailsStatusViewController : UIViewController < UINavigationControllerDelegate, LocationsViewControllerDelegate>

@property (strong, nonatomic) Task *task;
@property (strong, nonatomic) id<CancelRequestOnDetailsDelegate> delegate;
@property (strong, nonatomic) id<CancelMissionOnDetailsDelegate> missionDelegate;
@property (strong, nonatomic) NSNumber *startLatitude;
@property (strong, nonatomic) NSNumber *startLongitude;
@property (strong, nonatomic) NSNumber *endLatitude;
@property (strong, nonatomic) NSNumber *endLongitude;
@end

@protocol CancelRequestOnDetailsDelegate
-(void) didCancelRequest;
@end

@protocol CancelMissionOnDetailsDelegate
-(void) didCancelMission;
@end

NS_ASSUME_NONNULL_END
