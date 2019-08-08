//
//  ChooseLocationPopUpViewController.h
//  TaskU
//
//  Created by rhaypapenfuzz on 8/1/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChooseLocationPopUpViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UITextField *stateTextField;
@property NSString *userLocation;
@end

NS_ASSUME_NONNULL_END
