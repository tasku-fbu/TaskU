//
//  CustomAlert.m
//  TaskU
//
//  Created by panzaldo on 8/5/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "CustomAlert.h"

@implementation CustomAlert


//Override the two default initializers that are inherent to UIView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self customInit];
    }
    return self;
}


//Our custom init
-(void)customInit{
    [[NSBundle mainBundle] loadNibNamed:@"AlertView" owner:self options:nil];
    self.img.layer.cornerRadius = 30;
    self.img.layer.borderColor = [UIColor whiteColor].CGColor;
    self.img.layer.borderWidth = 2;
    self.parentView.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height);
    self.alertView.layer.cornerRadius = 10;
    //Add parent to subview of window
    self.parentView.autoresizingMask = (UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight);
    
    self.parentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.6];    
}

/*
 ShowAlert
    Creates a custom alert, depending on the need
 @params: title: title of the alert
          message: message you want to give
          alert type: the kind of alert (success, network failure etc
 */
- (void) showAlert: (NSString*)title withMessage: (NSString*)message withAlert: (NSString*)alertType {
    
    self.titleLabel.text = title;
    self.messageLabel.text = message;
    
    if([alertType isEqualToString:@"success"]){
            [self.img setImage:[UIImage imageNamed:@"success"]];
            self.doneButton.backgroundColor = [UIColor colorNamed:@"darkGreen"];
    
    } else if ([alertType isEqualToString:@"failure"]){
            [self.img setImage:[UIImage imageNamed:@"failure"]];
            self.doneButton.backgroundColor = [UIColor redColor];
    }
    
    [UIApplication.sharedApplication.keyWindow addSubview:self.parentView];
    
}
- (IBAction)onTapDone:(id)sender {
    
    [self.buttonDelegate didTapButton];
}

@end
