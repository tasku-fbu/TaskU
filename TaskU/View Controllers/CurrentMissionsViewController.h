//
//  CurrentMissionsViewController.h
//  TaskU
//
//  Created by lucyyyw on 7/22/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskCell.h"
#import "DetailsInfoViewController.h"
#import "DetailsViewController.h"
#import "DetailsStatusViewController.h"



NS_ASSUME_NONNULL_BEGIN

@interface CurrentMissionsViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,TaskCellDelegate,CancelMissionOnDetailsDelegate>

@end

NS_ASSUME_NONNULL_END
