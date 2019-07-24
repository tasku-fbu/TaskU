//
//  Message.m
//  TaskU
//
//  Created by lucyyyw on 7/23/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "Message.h"

@implementation Message

@dynamic sender;
@dynamic receiver;
@dynamic text;

+ (nonnull NSString *)parseClassName {
    return @"Message";
}

+ (void)sendMessage: (NSString * _Nullable) text toReceiver:(PFUser * _Nullable) receiver withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    Message *newMessage = [Message new];
    newMessage.sender = [PFUser currentUser];
    newMessage.text = text;
    newMessage.receiver = receiver;
    
    [newMessage saveInBackgroundWithBlock: completion];
    
}



@end
