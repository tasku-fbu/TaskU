//
//  Task.h
//  TaskU
//
//  Created by panzaldo on 7/16/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import <Parse/Parse.h>
#import "Foundation/Foundation.h"

NS_ASSUME_NONNULL_BEGIN

@interface Task : PFObject<PFSubclassing>

@property (strong, nonatomic) NSString *taskName;
@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) PFUser *requester;
@property (strong, nonatomic) PFUser *missioner;
@property (strong, nonatomic) PFFileObject *taskImage;
@property (strong, nonatomic) NSString *startAddress;
@property (strong, nonatomic) NSDate *taskDate;
@property (strong, nonatomic) NSString *taskDescription;
@property (strong, nonatomic) NSString *taskDifficulty;
@property (strong, nonatomic) NSString *completionStatus;

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image;
+ (void) postTask: ( NSString * _Nullable )taskName withStart: ( NSString * _Nullable )startAddress withDate: (NSDate *_Nullable)taskDate withDifficulty: ( NSString * _Nullable )taskDifficulty withDescription: ( NSString * _Nullable )taskDescription withCompletion: (PFBooleanResultBlock  _Nullable)completion;

@end

NS_ASSUME_NONNULL_END
