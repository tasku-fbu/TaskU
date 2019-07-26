//
//  Task.m
//  TaskU
//
//  Created by panzaldo on 7/16/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "Task.h"
#import "Parse/Parse.h"


@implementation Task

@dynamic taskName;
@dynamic category;
@dynamic requester;
@dynamic missioner;
@dynamic taskImage;
@dynamic startAddress;
@dynamic completionStatus;
@dynamic endAddress;
@dynamic taskDate;
@dynamic taskDescription;
@dynamic pay;
@dynamic hours;
@dynamic minutes;
@dynamic startLatitude;
@dynamic startLongitude;
@dynamic endLatitude;
@dynamic endLongitude;
+(nonnull NSString*)parseClassName{
    return @"Task";
}


//Converts file to image
+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
    // check if image is not nil
    if (!image) {
        return nil;
    }
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}


//To upload the user task to Parse, get user input from newTaskViewController. Then, call postTask from NewTaskViewController by passing all the required arguments into it
+ (void) postTask: ( NSString * _Nullable )taskName withStart: ( NSString * _Nullable )startAddress withEnd: ( NSString * _Nullable )endAddress withStartLatitude: ( NSNumber * _Nullable )startLatitude withStartLongitude: ( NSNumber * _Nullable )startLongitude withEndLatitude: ( NSNumber * _Nullable )endLatitude withEndLongitude: ( NSNumber * _Nullable )endLongitude withCategory: ( NSString * _Nullable )category withDate: (NSDate *_Nullable)taskDate withHours: ( NSString * _Nullable )hours withMinutes: ( NSString * _Nullable )minutes withPay: ( NSString * _Nullable )pay withDescription: ( NSString * _Nullable )taskDescription withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    Task *newTask = [Task new];
    newTask.requester = [PFUser currentUser];
    newTask.taskName = taskName;
    newTask.startAddress = startAddress;
    newTask.endAddress = endAddress;
    newTask.taskDate = taskDate;
    newTask.taskDescription = taskDescription;
    newTask.completionStatus = @"created";
    newTask.category = category;
    //convert Task time to NSNumber
    newTask.hours = [NSNumber numberWithInt:[hours intValue]];
    newTask.minutes = [NSNumber numberWithInt:[minutes intValue]];
    
    newTask.pay = [NSNumber numberWithInt:[pay intValue]];
    
    newTask.startLatitude = startLatitude;
    newTask.startLongitude = startLongitude;
    newTask.endLatitude = endLatitude;
    newTask.endLongitude = endLongitude;
   
    //POST Request
    [newTask saveInBackgroundWithBlock: completion];
}
// withStartCoordinates: ( NSArray * _Nullable )startCoordinates withEndCoordinates: ( NSArray * _Nullable )endCoordinates
@end

