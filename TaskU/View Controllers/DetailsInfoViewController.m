//
//  DetailsInfoViewController.m
//  TaskU
//
//  Created by lucyyyw on 7/17/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "DetailsInfoViewController.h"

@interface DetailsInfoViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableVIew;

@property (weak, nonatomic) IBOutlet UILabel *rusernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *rnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *runiversityLabel;
@property (weak, nonatomic) IBOutlet UILabel *remailLabel;
@property (weak, nonatomic) IBOutlet UILabel *rphoneLabel;

@property (weak, nonatomic) IBOutlet UILabel *taskidLabel;
@property (weak, nonatomic) IBOutlet UILabel *taskNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *payLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *dueLabel;

@property (weak, nonatomic) IBOutlet UILabel *hourLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;

@property (weak, nonatomic) IBOutlet UILabel *musernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *muniversityLabel;
@property (weak, nonatomic) IBOutlet UILabel *memailLabel;
@property (weak, nonatomic) IBOutlet UILabel *mphoneLabel;


@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *view1;



@end

@implementation DetailsInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableVIew.rowHeight = UITableViewAutomaticDimension;

    
    
    //Rounded corners only on top and bottom cell
    self.topView.layer.cornerRadius = 10;
    self.topView.layer.masksToBounds = YES;
    self.topView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
    
    self.view1.layer.cornerRadius = 10;
    self.view1.layer.masksToBounds = YES;
    self.view1.layer.maskedCorners = kCALayerMaxXMaxYCorner | kCALayerMinXMaxYCorner;
    
    
    [self showingTaskDetails];
    [self showRequesterInfo];
    [self showMissionerInfo];
    
}




- (void) showingTaskDetails {
    
    self.taskidLabel.text = [NSString stringWithFormat:@"ID: %@", self.task.objectId];

    //self.taskidLabel.text = self.task.objectId;
    self.taskNameLabel.text = self.task[@"taskName"];
    self.categoryLabel.text = self.task[@"category"];
     self.descriptionLabel.text = self.task[@"taskDescription"];
    
    NSNumber *hour = self.task[@"hours"];
    NSNumber *minute = self.task[@"minutes"];
    int hr = [hour intValue];
    int min = [minute intValue];
    if (hr == 0) {
        self.timeLabel.text = [NSString stringWithFormat:@"%imin", min];
    } else if (min == 0){
        self.timeLabel.text = [NSString stringWithFormat:@"%ihr", hr];
    } else {
        self.timeLabel.text = [NSString stringWithFormat:@"%ihr %imin", hr,min];
    }
    
    NSNumber *payment = self.task[@"pay"];
    int pay = [payment intValue];
    self.payLabel.text = [NSString stringWithFormat:@"$%i",pay];
    
    NSString *startString = @"";
    if (self.task[@"startAddress"]) {
        if (![self.task[@"startAddress"] isEqualToString:@""]) {
            startString = [NSString stringWithFormat:@"FROM %@ ", self.task[@"startAddress"]];
        }
    }
    self.addressLabel.text = self.task[@"endAddress"];
    

    
    NSDate *date = self.task[@"taskDate"];
    NSString *dateString = [self stringfromDateHelper:date];
    NSString *dateString2 = [self stringfromDateHelper2:date];

  //  self.dueLabel.text = [NSString stringWithFormat:@"due %@.", dateString];
    self.hourLabel.text = dateString;
    self.monthLabel.text = dateString2;


}

- (NSString *) stringfromDateHelper: (NSDate *) date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

- (NSString *) stringfromDateHelper2: (NSDate *) date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM.d"];
    NSString *dateString2 = [dateFormatter stringFromDate:date];
    return dateString2;
}


- (void) showRequesterInfo {
    PFUser *requester = self.task.requester;
    self.rusernameLabel.text = requester[@"username"];
    self.rnameLabel.text = [NSString stringWithFormat:@"%@ %@", requester[@"firstName"], requester[@"lastName"]];
    self.runiversityLabel.text = requester[@"university"];
    self.remailLabel.text = requester[@"email"];
    
    self.rphoneLabel.text = [NSString stringWithFormat:@" %@.",requester[@"phoneNumber"]];
    
}

- (void) showMissionerInfo {
    PFUser *missioner = self.task[@"missioner"];
    self.musernameLabel.text = missioner[@"username"];
    self.mnameLabel.text = [NSString stringWithFormat:@"%@ %@", missioner[@"firstName"],missioner[@"lastName"]];
    self.muniversityLabel.text = missioner[@"university"];
    self.memailLabel.text = missioner[@"email"];
    
    self.mphoneLabel.text = [NSString stringWithFormat:@"Phone: %@.",missioner[@"phoneNumber"]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 2)
    {
        if(!self.task[@"missioner"])
            return 0;
        else
            return 1;
    }
    else if (section == 0)
    {
        return 7;
    } else {
        return 1;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(!self.task[@"missioner"] && section == 2)
        return [[UIView alloc] initWithFrame:CGRectZero];
    return nil;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
