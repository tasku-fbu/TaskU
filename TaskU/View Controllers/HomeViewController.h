//  HomeViewController.h
//  TaskU
//
//  Created by rhaypapenfuzz on 7/15/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditProfileViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : UIViewController  <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideButton;

@end

NS_ASSUME_NONNULL_END
