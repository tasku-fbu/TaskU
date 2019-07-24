//
//  ContactCell.h
//  TaskU
//
//  Created by lucyyyw on 7/23/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContactCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *contactProfileImageView;
@property (weak, nonatomic) IBOutlet UILabel *contactUsernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *latestTextLabel;

@end

NS_ASSUME_NONNULL_END
