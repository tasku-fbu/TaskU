//
//  ChatMessagesViewController.h
//  TaskU
//
//  Created by lucyyyw on 7/23/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MessageSentDelegate;

@interface ChatMessagesViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (weak,nonatomic) PFUser *contact;


@property (strong, nonatomic) id<MessageSentDelegate> delegate;

@end




@protocol MessageSentDelegate
-(void) newMessageSent;
@end

NS_ASSUME_NONNULL_END
