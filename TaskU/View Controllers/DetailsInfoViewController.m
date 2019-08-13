//
//  DetailsInfoViewController.m
//  TaskU
//
//  Created by lucyyyw on 7/17/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "DetailsInfoViewController.h"
#import "UIImageView+AFNetworking.h"
#import "PanTabAnimator.h"
#import "VCTransitionsLibrary/CEHorizontalSwipeInteractionController.h"

@interface DetailsInfoViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableVIew;

@property (weak, nonatomic) IBOutlet UILabel *rusernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *rnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *runiversityLabel;
@property (weak, nonatomic) IBOutlet UILabel *remailLabel;
@property (weak, nonatomic) IBOutlet UILabel *rphoneLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rProfileImage;

@property (weak, nonatomic) IBOutlet UILabel *taskidLabel;
@property (weak, nonatomic) IBOutlet UILabel *taskNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *payLabel;
@property (weak, nonatomic) IBOutlet UILabel *startAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *endAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *dueLabel;

@property (weak, nonatomic) IBOutlet UILabel *musernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *muniversityLabel;
@property (weak, nonatomic) IBOutlet UILabel *memailLabel;
@property (weak, nonatomic) IBOutlet UILabel *mphoneLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mProfileImage;


@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *requesterTopView;



@end

@implementation DetailsInfoViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableVIew.rowHeight = UITableViewAutomaticDimension;
    
    //Sets round corners for section cells
    [self viewFormatterHelper:self.topView];
    [self viewFormatterHelper:self.view1];
    [self viewFormatterHelper:self.requesterTopView];
    
    [self showingTaskDetails];
    [self showRequesterInfo];
    [self showMissionerInfo];
    
    
     UISwipeGestureRecognizer *toLeftSwipeRecognizer = [[[UISwipeGestureRecognizer alloc] init] initWithTarget:self action:@selector(slideToLeftWithGestureRecognizer:)];
     toLeftSwipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
     [self.view addGestureRecognizer:toLeftSwipeRecognizer];
     
}

- (void) slideToLeftWithGestureRecognizer:(UISwipeGestureRecognizer *) gestureRecognizer {
    
    CATransition *transition = [CATransition animation];
    transition.duration = 1;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:transition forKey:nil];
    self.tabBarController.selectedIndex -= 1;
    
    
}

- (void)viewFormatterHelper: (UIView *) view {
    view.layer.cornerRadius = 10;
    view.layer.masksToBounds = YES;
    
    if([view isEqual:self.topView]){
        view.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
    }
    else if([view isEqual:self.view1]){
        view.layer.maskedCorners = kCALayerMaxXMaxYCorner | kCALayerMinXMaxYCorner;
    }
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
    
    NSString *startString = @"FROM Your choice!";

    if (self.task[@"startAddress"]) {
        if (![self.task[@"startAddress"] isEqualToString:@""]) {
            startString = [NSString stringWithFormat:@"FROM %@ ", self.task[@"startAddress"]];
            self.startAddressLabel.text = startString;
          //  [self.startAddressLabel setFont:[UIFont fontWithName:@"Quicksand-Regular" size:18.0f]];
        }
    }
    self.startAddressLabel.text = startString;
    self.endAddressLabel.text = [NSString stringWithFormat:@"TO %@ ", self.task[@"endAddress"]];
    
    NSDate *date = self.task[@"taskDate"];
    self.dueLabel.text = [self stringfromDateHelper:date];

}

- (NSString *) stringfromDateHelper: (NSDate *) date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE, MMM d @ h:mm a"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

- (void) showRequesterInfo {
    PFUser *requester = self.task.requester;
    
    self.rusernameLabel.text = [NSString stringWithFormat:@"@%@",requester[@"username"]];
    self.rnameLabel.text = [NSString stringWithFormat:@"%@ %@", requester[@"firstName"], requester[@"lastName"]];
    self.runiversityLabel.text = requester[@"university"];
    self.remailLabel.text = requester[@"email"];
    
    self.rphoneLabel.text = [NSString stringWithFormat:@" %@",requester[@"phoneNumber"]];
    PFFileObject *imageFile = requester[@"profileImage"];
    
    NSString *urlString = imageFile.url;
    [self.rProfileImage setImageWithURL:[NSURL URLWithString:urlString]];
    
    self.rProfileImage.layer.cornerRadius = 40;
    self.rProfileImage.clipsToBounds = YES;
    
}

- (void) showMissionerInfo {
    PFUser *missioner = self.task[@"missioner"];
    self.musernameLabel.text = [NSString stringWithFormat:@"@%@",missioner[@"username"]];
    self.mnameLabel.text = [NSString stringWithFormat:@"%@ %@", missioner[@"firstName"],missioner[@"lastName"]];
    self.muniversityLabel.text = missioner[@"university"];
    self.memailLabel.text = missioner[@"email"];
    
    self.mphoneLabel.text = [NSString stringWithFormat:@"Phone: %@",missioner[@"phoneNumber"]];
    
    PFFileObject *imageFile = missioner[@"profileImage"];
    NSString *urlString = imageFile.url;
    [self.mProfileImage setImageWithURL:[NSURL URLWithString:urlString]];
    
    self.mProfileImage.layer.cornerRadius = 40;
    self.mProfileImage.clipsToBounds = YES;
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
        return 9;
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
