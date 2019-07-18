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

@property (weak, nonatomic) IBOutlet UILabel *musernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *muniversityLabel;
@property (weak, nonatomic) IBOutlet UILabel *memailLabel;
@property (weak, nonatomic) IBOutlet UILabel *mphoneLabel;

@end

@implementation DetailsInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableVIew.rowHeight = UITableViewAutomaticDimension;
    [self showingTaskDetails];
    
}

- (void) showingTaskDetails {
    self.taskidLabel.text = self.task.objectId;
    self.taskNameLabel.text = self.task[@"taskName"];
    self.categoryLabel.text = [NSString stringWithFormat:@"Category: %@",self.task[@"category"]];
    self.descriptionLabel.text = [NSString stringWithFormat:@"Description:\n  %@", self.task[@"taskDescription"]];
    
    NSNumber *hour = self.task[@"hours"];
    NSNumber *minute = self.task[@"minutes"];
    int hr = [hour intValue];
    int min = [minute intValue];
    if (hr == 0) {
        self.timeLabel.text = [NSString stringWithFormat:@"Estimated to be completed within %imin", min];
    } else if (min == 0){
        self.timeLabel.text = [NSString stringWithFormat:@"Estimated to be completed within %ihr", hr];
    } else {
        self.timeLabel.text = [NSString stringWithFormat:@"Estimated to be completed within %ihr %imin", hr,min];
    }
    
    NSNumber *payment = self.task[@"pay"];
    int pay = [payment intValue];
    self.payLabel.text = [NSString stringWithFormat:@"Payment amount: $%i.",pay];
    
    NSString *startString = @"";
    if (self.task[@"startAddress"]) {
        if (![self.task[@"startAddress"] isEqualToString:@""]) {
            startString = [NSString stringWithFormat:@"FROM %@ ", self.task[@"startAddress"]];
        }
    }
    self.addressLabel.text = [NSString stringWithFormat:@"%@TO %@",
                                  startString,self.task[@"endAddress"]];
    
    NSDate *date = self.task[@"taskDate"];
    NSString *dateString = [self stringfromDateHelper:date];
    self.dueLabel.text = [NSString stringWithFormat:@"Due by %@.", dateString];
}

- (NSString *) stringfromDateHelper: (NSDate *) date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm, MM.d, YYYY"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
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
