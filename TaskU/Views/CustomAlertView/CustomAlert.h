//
//  CustomAlert.h
//  TaskU
//
//  Created by panzaldo on 8/5/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol ButtonTapDelegate
-(void)didTapButton;
@end

@interface CustomAlert : UIView
@property(weak,nonatomic) id<ButtonTapDelegate> buttonDelegate;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIView *parentView;
@property (weak, nonatomic) IBOutlet UIView *alertView;

- (void) showAlert: (NSString*)title withMessage: (NSString*)message withAlert: (NSString*)alertType; 
@end



NS_ASSUME_NONNULL_END
