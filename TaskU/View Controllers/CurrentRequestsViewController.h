//
//  CurrentRequestsViewController.h
//  TaskU
//
//  Created by lucyyyw on 7/22/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskCell.h"
#import "DetailsStatusViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CurrentRequestsViewController : UIViewController <UITableViewDelegate,UITableViewDataSource, TaskCellDelegate,CancelRequestOnDetailsDelegate>

@end

NS_ASSUME_NONNULL_END
