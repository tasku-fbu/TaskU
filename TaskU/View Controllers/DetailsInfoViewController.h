//
//  DetailsInfoViewController.h
//  TaskU
//
//  Created by lucyyyw on 7/17/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsInfoViewController : UITableViewController //<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) Task *task;

@end

NS_ASSUME_NONNULL_END
