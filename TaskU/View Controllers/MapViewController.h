//
//  MapViewController.h
//  TaskU
//
//  Created by rhaypapenfuzz on 7/21/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationsViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface MapViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, LocationsViewControllerDelegate>

@end

NS_ASSUME_NONNULL_END
