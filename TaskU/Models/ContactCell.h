//
//  ContactCell.h
//  TaskU
//
//  Created by lucyyyw on 7/23/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ContactCellDelegate;


@interface ContactCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *contactProfileImageView;
@property (weak, nonatomic) IBOutlet UILabel *contactUsernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *latestTextLabel;
@property (strong, nonatomic) id<ContactCellDelegate> delegate;
@property (strong, nonatomic) PFUser *contact;
@end

@protocol ContactCellDelegate
-(void) didTapCell;
@end
NS_ASSUME_NONNULL_END
