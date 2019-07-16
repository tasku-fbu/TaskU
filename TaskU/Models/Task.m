//
//  Task.m
//  TaskU
//
//  Created by panzaldo on 7/16/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "Task.h"

@implementation Task

@dynamic category;
@dynamic requester;
@dynamic missioner;
@dynamic taskImage;
@dynamic startAddress;
@dynamic endDate;
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

@end
