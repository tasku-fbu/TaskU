//
//  LocationsViewController.h
//  TaskU
//
//  Created by rhaypapenfuzz on 7/21/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LocationsViewController;

@protocol LocationsViewControllerDelegate
@required
- (void)locationsViewController:(LocationsViewController *)controller didPickLocationWithLatitude:(NSNumber *)latitude longitude:(NSNumber *)longitude;
@optional
- (void)locationsViewController:(LocationsViewController *)controller didPickLocationWithName:(NSString *) locationName address:(NSString *)locationAddress;
@end


@interface LocationsViewController : UIViewController
@property (weak, nonatomic) id<LocationsViewControllerDelegate> delegate;
@property (assign, nonatomic) BOOL isNewTaskViewController;
@end

NS_ASSUME_NONNULL_END
