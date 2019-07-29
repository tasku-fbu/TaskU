//
//  Timeline1ViewController.h
//  TaskU
//
//  Created by lucyyyw on 7/16/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskCell.h"
#import "DetailsStatusViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface Timeline1ViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,TaskCellDelegate, CancelRequestOnDetailsDelegate, LocationsViewControllerDelegate,UISearchBarDelegate>
@property (nonatomic, strong) NSString * category;


@end

NS_ASSUME_NONNULL_END
