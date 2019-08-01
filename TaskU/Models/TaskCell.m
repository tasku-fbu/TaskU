//
//  TaskCell.m
//  TaskU
//
//  Created by lucyyyw on 7/16/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "TaskCell.h"
#import "DetailsViewController.h"

@implementation TaskCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)onClickDetails:(id)sender {
    [self.delegate didTapDetails:self];
}

- (void) showCell:(TaskCell*) cell withTask: (Task*) task {
    cell.cellView.layer.cornerRadius = 16;
    cell.cellView.clipsToBounds = true;
    //cell.cellView.backgroundColor = [UIColor lightGrayColor];
    cell.backgroundColor = [UIColor colorWithRed:240/255.0 green:248/255.0 blue:255 alpha:1];
    
    cell.task = task;
    cell.titleLabel.text = task[@"taskName"];
    
    
    NSNumber *payment = task[@"pay"];
    int pay = [payment intValue];
    cell.paymentLabel.text = [NSString stringWithFormat:@"$%i",pay];
    
    NSString *startString = @"Your choice!";
    cell.startLabel.font = [UIFont italicSystemFontOfSize:17.0f];
    if (task[@"startAddress"]) {
        if (![task[@"startAddress"] isEqualToString:@""]) {
            startString = [NSString stringWithFormat:@"FROM %@ ", task[@"startAddress"]];
            cell.startLabel.text = startString;
            [cell.startLabel setFont:[UIFont fontWithName:@"Quicksand-Regular" size:18.0f]];
        }
        
    }
    cell.startLabel.text = startString;
    
    cell.destinationLabel.text = [NSString stringWithFormat:@"TO %@",
                                  task[@"endAddress"]];
    
    
    NSDate *date = task[@"taskDate"];
    NSString *dateString = [self stringfromDateHelper:date];
    cell.dateLabel.text = [NSString stringWithFormat:@"due %@", dateString];
    
    
    NSNumber *hour = task[@"hours"];
    NSNumber *minute = task[@"minutes"];
    int hr = [hour intValue];
    int min = [minute intValue];
    if (hr == 0) {
        cell.timeLabel.text = [NSString stringWithFormat:@"%imin", min];
    } else if (min == 0){
        cell.timeLabel.text = [NSString stringWithFormat:@"%ihr", hr];
    } else {
        cell.timeLabel.text = [NSString stringWithFormat:@"%ihr %imin", hr,min];
    }
}

- (void) showRequestCell:(TaskCell*) cell withRequest: (Task*) task {
    cell.cellView.layer.cornerRadius = 16;
    cell.cellView.clipsToBounds = true;
    //cell.cellView.backgroundColor = [UIColor lightGrayColor];
    //cell.backgroundColor = [UIColor colorWithRed:240/255.0 green:248/255.0 blue:255 alpha:1];
    
    cell.task = task;
    cell.titleLabel.text = task[@"taskName"];
    
    /*
    NSNumber *payment = task[@"pay"];
    int pay = [payment intValue];
    cell.paymentLabel.text = [NSString stringWithFormat:@"$%i",pay];
    */
     
    NSString *startString = @"Your choice!";
    cell.startLabel.font = [UIFont italicSystemFontOfSize:14.0f];
    if (task[@"startAddress"]) {
        if (![task[@"startAddress"] isEqualToString:@""]) {
            startString = [NSString stringWithFormat:@"FROM %@ ", task[@"startAddress"]];
            cell.startLabel.text = startString;
            [cell.startLabel setFont:[UIFont fontWithName:@"Quicksand-Regular" size:16.0f]];
        }
        
    }
    cell.startLabel.text = startString;
    
    cell.destinationLabel.text = [NSString stringWithFormat:@"TO %@",
                                  task[@"endAddress"]];
    
    
    NSDate *date = task[@"taskDate"];
    NSString *dateString = [self stringfromDateHelper:date];
    cell.dateLabel.text = [NSString stringWithFormat:@"due %@", dateString];
    
    NSString *statusString = task[@"completionStatus"];
    cell.statusLabel.text = statusString;
    
    
    /*
    NSNumber *hour = task[@"hours"];
    NSNumber *minute = task[@"minutes"];
    int hr = [hour intValue];
    int min = [minute intValue];
    if (hr == 0) {
        cell.timeLabel.text = [NSString stringWithFormat:@"%imin", min];
    } else if (min == 0){
        cell.timeLabel.text = [NSString stringWithFormat:@"%ihr", hr];
    } else {
        cell.timeLabel.text = [NSString stringWithFormat:@"%ihr %imin", hr,min];
    }
     */
}

- (void) showMissionCell:(TaskCell*) cell withMission: (Task*) task {
    cell.cellView.layer.cornerRadius = 16;
    cell.cellView.clipsToBounds = true;
    //cell.cellView.backgroundColor = [UIColor lightGrayColor];
    cell.backgroundColor = [UIColor colorWithRed:240/255.0 green:248/255.0 blue:255 alpha:1];
    
    cell.task = task;
    cell.titleLabel.text = task[@"taskName"];
    
    
    NSNumber *payment = task[@"pay"];
    int pay = [payment intValue];
    cell.paymentLabel.text = [NSString stringWithFormat:@"$%i",pay];
    
    NSString *startString = @"Your choice!";
    cell.startLabel.font = [UIFont italicSystemFontOfSize:17.0f];
    if (task[@"startAddress"]) {
        if (![task[@"startAddress"] isEqualToString:@""]) {
            startString = [NSString stringWithFormat:@"FROM %@ ", task[@"startAddress"]];
            cell.startLabel.text = startString;
            [cell.startLabel setFont:[UIFont fontWithName:@"Quicksand-Regular" size:18.0f]];
        }
        
    }
    cell.startLabel.text = startString;
    
    cell.destinationLabel.text = [NSString stringWithFormat:@"TO %@",
                                  task[@"endAddress"]];
    
    
    NSDate *date = task[@"taskDate"];
    NSString *dateString = [self stringfromDateHelper:date];
    cell.dateLabel.text = [NSString stringWithFormat:@"due %@", dateString];
    
    
    NSNumber *hour = task[@"hours"];
    NSNumber *minute = task[@"minutes"];
    int hr = [hour intValue];
    int min = [minute intValue];
    if (hr == 0) {
        cell.timeLabel.text = [NSString stringWithFormat:@"%imin", min];
    } else if (min == 0){
        cell.timeLabel.text = [NSString stringWithFormat:@"%ihr", hr];
    } else {
        cell.timeLabel.text = [NSString stringWithFormat:@"%ihr %imin", hr,min];
    }
}

- (NSString *) stringfromDateHelper: (NSDate *) date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE, MMM d @ HH:mm a"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

@end
