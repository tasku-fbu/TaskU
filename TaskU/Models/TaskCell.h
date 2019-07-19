//
//  TaskCell.h
//  TaskU
//
//  Created by lucyyyw on 7/16/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "TaskCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TaskCellDelegate;



@interface TaskCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *requesterLabel;
@property (weak, nonatomic) IBOutlet UILabel *paymentLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *destinationLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) Task *task;

@property (nonatomic, weak) id<TaskCellDelegate> delegate;

@end

@protocol TaskCellDelegate

- (void) didTapDetails:(TaskCell *) cell;

@end


NS_ASSUME_NONNULL_END
