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
@property (strong, nonatomic) PFFileObject *taskImage; //optional property: usage is more for the misssioner
@property (strong, nonatomic) NSString *startAddress;
@property (strong, nonatomic) NSString *endAddress;
@property (strong, nonatomic) NSDate *taskDate;
@property (strong, nonatomic) NSString *taskDescription;
@property (strong, nonatomic) NSString *completionStatus;
@property (strong, nonatomic) NSNumber *hours;
@property (strong, nonatomic) NSNumber *minutes;
@property (strong, nonatomic) NSNumber *pay;
@property (strong, nonatomic) NSNumber *startLatitude;
@property (strong, nonatomic) NSNumber *startLongitude;
@property (strong, nonatomic) NSNumber *endLatitude;
@property (strong, nonatomic) NSNumber *endLongitude;

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image;
+ (void) postTask: ( NSString * _Nullable )taskName withStart: ( NSString * _Nullable )startAddress withEnd: ( NSString * _Nullable )endAddress withStartLatitude: ( NSNumber * _Nullable )startLatitude withStartLongitude: ( NSNumber * _Nullable )startLongitude withEndLatitude: ( NSNumber * _Nullable )endLatitude withEndLongitude: ( NSNumber * _Nullable )endLongitude withCategory: ( NSString * _Nullable )category withDate: (NSDate *_Nullable)taskDate withHours: ( NSString * _Nullable )hours withMinutes: ( NSString * _Nullable )minutes withPay: ( NSString * _Nullable )pay withDescription: ( NSString * _Nullable )taskDescription withCompletion: (PFBooleanResultBlock  _Nullable)completion;

@end

NS_ASSUME_NONNULL_END
