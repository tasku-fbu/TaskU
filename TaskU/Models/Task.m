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
@dynamic taskDate;
@dynamic taskDescription;
@dynamic taskDifficulty;
@dynamic completionStatus;

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
+ (void) postTask: ( NSString * _Nullable )taskName withStart: ( NSString * _Nullable )startAddress withEnd: ( NSString * _Nullable )endAddress withDate: (NSDate *_Nullable)taskDate withDifficulty: ( NSString * _Nullable )taskDifficulty withDescription: ( NSString * _Nullable )taskDescription withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    Task *newTask = [Task new];
    newTask.requester = [PFUser currentUser];
    newTask.taskName = taskName;
    newTask.startAddress = startAddress;
    newTask.endAddress = endAddress;
    newTask.taskDate = taskDate;
    newTask.taskDifficulty = taskDifficulty;
    newTask.taskDescription = taskDescription;
    
    //POST Request
    [newTask saveInBackgroundWithBlock: completion];
}

@end

