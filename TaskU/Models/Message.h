//
//  Message.h
//  TaskU
//
//  Created by lucyyyw on 7/23/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//


#import <Parse/Parse.h>
#import "Foundation/Foundation.h"

NS_ASSUME_NONNULL_BEGIN

@interface Message : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString * _Nonnull text;
@property (nonatomic, strong) PFUser * _Nonnull sender;
@property (nonatomic, strong) PFUser * _Nonnull receiver;

+ (void)sendMessage: (NSString * _Nullable) text toSender:(PFUser * _Nullable) receiver withCompletion: (PFBooleanResultBlock  _Nullable)completion;

@end

NS_ASSUME_NONNULL_END
