//
//  EditProfileViewController.h
//  TaskU
//
//  Created by panzaldo on 7/17/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol editedProfile
- (void) didEditProfilewithImage: (UIImage* ) image;
- (void) didEditProfileName;
@end
@interface EditProfileViewController : UITableViewController 
@property (weak, nonatomic) id <editedProfile> delegate;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideButton;

@end

NS_ASSUME_NONNULL_END

