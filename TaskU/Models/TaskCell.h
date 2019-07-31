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
@property (weak, nonatomic) IBOutlet UIImageView *requesterProfile;
@property (weak, nonatomic) IBOutlet UILabel *startLabel;
@property (weak, nonatomic) IBOutlet UIView *cellView;


@property (strong, nonatomic) Task *task;

@property (nonatomic, weak) id<TaskCellDelegate> delegate;

- (void) showCell:(TaskCell*) taskCell withTask: (Task*) task ;
- (void) showRequestCell:(TaskCell*) cell withRequest: (Task*) task;
- (void) showMissionCell:(TaskCell*) cell withMission: (Task*) task;

@end

@protocol TaskCellDelegate

- (void) didTapDetails:(TaskCell *) cell;

@end


NS_ASSUME_NONNULL_END
