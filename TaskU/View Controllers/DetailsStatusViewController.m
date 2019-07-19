//
//  DetailsStatusViewController.m
//  TaskU
//
//  Created by lucyyyw on 7/17/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "DetailsStatusViewController.h"

@interface DetailsStatusViewController ()
@property (weak, nonatomic) IBOutlet UILabel *createLabel;
@property (weak, nonatomic) IBOutlet UILabel *acceptLabel;
@property (weak, nonatomic) IBOutlet UILabel *completeLabel;
@property (weak, nonatomic) IBOutlet UILabel *payLabel;
@property (weak, nonatomic) IBOutlet UIButton *acceptButton;
@property (weak, nonatomic) IBOutlet UIButton *completeButton;
@property (weak, nonatomic) IBOutlet UIButton *payButton;



@end

@implementation DetailsStatusViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showCreateLabel];
    [self showAcceptLabel];
    [self showCompleteLabel];
    [self showPayLabel];
}

- (void) showCreateLabel {
    PFUser *requester = self.task[@"requester"];
    NSString *username = requester.username;
    
    NSString *dateString = [self stringfromDateHelper:self.task.createdAt];
    NSString *display = [NSString stringWithFormat:@"Created by requester @%@ at %@", username, dateString];
    self.createLabel.text = display;
}


- (void) showAcceptLabel {
    PFUser *missioner = self.task[@"missioner"];
    if (!missioner) {
        self.acceptLabel.text = @"Still awaiting for a missioner!!";
        self.acceptLabel.textColor = [UIColor grayColor];
    } else {
        self.acceptLabel.textColor = [UIColor blackColor];
        NSString *username = missioner.username;
        NSString *dateString = [self stringfromDateHelper:self.task[@"acceptedAt"]];
        NSString *display = [NSString stringWithFormat:@"Accepted by missioner @%@ at %@", username, dateString];
        self.acceptLabel.text = display;
    }
}

- (void) showCompleteLabel {
    PFUser *missioner = self.task[@"missioner"];
    NSDate *completedAt = self.task[@"completedAt"];
    
    if (!missioner) {
        self.completeLabel.text = @"Still awaiting for a missioner!!";
        self.completeLabel.textColor = [UIColor grayColor];
    } else if (!completedAt) {
        self.completeLabel.text = [NSString stringWithFormat:@"Still in progress by missioner %@...", missioner[@"username"]];
        self.completeLabel.textColor = [UIColor grayColor];
    } else {
        self.completeLabel.textColor = [UIColor blackColor];
        NSString *username = missioner.username;
        NSString *dateString = [self stringfromDateHelper:completedAt];
        NSString *display = [NSString stringWithFormat:@"Completed by missioner @%@ at %@", username, dateString];
        self.completeLabel.text = display;
    }
}

- (void) showPayLabel {
    PFUser *requester = self.task[@"requester"];
    PFUser *missioner = self.task[@"missioner"];
    NSDate *completedAt = self.task[@"completedAt"];
    NSDate *paidAt = self.task[@"paidAt"];
    
    if (!missioner) {
        self.payLabel.text = @"Still awaiting for a missioner!!";
        self.payLabel.textColor = [UIColor grayColor];
    } else if (!completedAt) {
        self.payLabel.text = [NSString stringWithFormat:@"Still in progress by missioner %@...", missioner[@"username"]];
        self.payLabel.textColor = [UIColor grayColor];
    } else if (!paidAt) {
        self.payLabel.text = [NSString stringWithFormat:@"Still awaiting pay from requester %@...", requester[@"username"]];
        self.payLabel.textColor = [UIColor grayColor];
    } else {
        self.payLabel.textColor = [UIColor blackColor];
        NSString *username = requester.username;
        NSString *dateString = [self stringfromDateHelper:paidAt];
        NSString *display = [NSString stringWithFormat:@"Paid by requester @%@ at %@", username, dateString];
        self.payLabel.text = display;
    }
}



- (NSString *) stringfromDateHelper: (NSDate *) date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm, MM.d, YYYY"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}




- (IBAction)onTapAcceptButton:(id)sender {
}
- (IBAction)onTapCompleteButton:(id)sender {
}
- (IBAction)onTapPayButton:(id)sender {
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
