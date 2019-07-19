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
    [self updateView];
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
    if (!missioner || [missioner isEqual:[NSNull null]]) {
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

- (void) showAcceptButton {
    PFUser *missioner = self.task[@"missioner"];
    PFUser *requester = self.task[@"requester"];
    
    if ([[PFUser currentUser].objectId isEqual:requester.objectId]) {
        self.acceptButton.hidden = YES;
        self.acceptButton.userInteractionEnabled = NO;
    } else if (!missioner || [missioner isEqual:[NSNull null]]) {
        self.acceptButton.hidden = NO;
        self.acceptButton.userInteractionEnabled = YES;
        [self.acceptButton setTitle:@"Accept" forState:UIControlStateNormal];
        [self.acceptButton setBackgroundColor:[UIColor colorWithRed:0.0 green:153/255.0 blue:0.0 alpha:1.0]];
        [self.acceptButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else if ([missioner.objectId isEqual:[PFUser currentUser].objectId] && [self.task[@"completionStatus"] isEqualToString:@"accepted"]) {
        self.acceptButton.hidden = NO;
        self.acceptButton.userInteractionEnabled = YES;
        [self.acceptButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [self.acceptButton setBackgroundColor:[UIColor redColor]];
        [self.acceptButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        self.acceptButton.hidden = YES;
        self.acceptButton.userInteractionEnabled = NO;
    }
}

- (void) showCompleteButton {
    PFUser *missioner = self.task[@"missioner"];
    PFUser *requester = self.task[@"requester"];
    if (self.task[@"acceptedAt"] && ![self.task[@"acceptedAt"] isEqual:[NSNull null]] && (!self.task[@"completedAt"] || [self.task[@"completedAt"] isEqual:[NSNull null]])) {
        if ([[PFUser currentUser].objectId isEqual:missioner.objectId]) {
            self.completeButton.hidden = NO;
            self.completeButton.userInteractionEnabled = YES;
            [self.completeButton setTitle:@"Complete" forState:UIControlStateNormal];
            [self.completeButton setBackgroundColor:[UIColor colorWithRed:0.1 green:0.25 blue:1 alpha:1.0]];
            [self.completeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        } else if ([[PFUser currentUser].objectId isEqual:requester.objectId]) {
            self.completeButton.hidden = NO;
            self.completeButton.userInteractionEnabled = YES;
            [self.completeButton setTitle:@"Contact missioner" forState:UIControlStateNormal];
            [self.completeButton setBackgroundColor:[UIColor colorWithRed:0.9 green:0.3 blue:0 alpha:1.0]];
            [self.completeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        } else {
            self.completeButton.hidden = YES;
            self.completeButton.userInteractionEnabled = NO;
        }
    } else {
        self.completeButton.hidden = YES;
        self.completeButton.userInteractionEnabled = NO;
    }
    
    
}


- (void) showCompleteLabel {
    PFUser *missioner = self.task[@"missioner"];
    NSDate *completedAt = self.task[@"completedAt"];
    
    if (!missioner || [missioner isEqual:[NSNull null]]) {
        self.completeLabel.text = @"Still awaiting for a missioner!!";
        self.completeLabel.textColor = [UIColor grayColor];
    } else if (!completedAt || [completedAt isEqual:[NSNull null]]) {
        self.completeLabel.text = [NSString stringWithFormat:@"Still in progress by missioner @%@...", missioner[@"username"]];
        self.completeLabel.textColor = [UIColor grayColor];
    } else {
        self.completeLabel.textColor = [UIColor blackColor];
        NSString *username = missioner.username;
        NSString *dateString = [self stringfromDateHelper:completedAt];
        NSString *display = [NSString stringWithFormat:@"Completed by missioner @%@ at @%@", username, dateString];
        self.completeLabel.text = display;
    }
}

- (void) showPayButton {
    PFUser *requester = self.task[@"requester"];
    PFUser *missioner = self.task[@"missioner"];
    if ([self.task[@"completionStatus"] isEqualToString:@"completed"]) {
        if ([[PFUser currentUser].objectId isEqual:requester.objectId]) {
            self.payButton.hidden = NO;
            self.payButton.userInteractionEnabled = YES;
            [self.payButton setTitle:@"Confirm & Pay" forState:UIControlStateNormal];
            [self.payButton setBackgroundColor:[UIColor colorWithRed:0.1 green:0.25 blue:1 alpha:1.0]];
            [self.payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        } else if ([[PFUser currentUser].objectId isEqualToString:missioner.objectId]){
            self.payButton.hidden = NO;
            self.payButton.userInteractionEnabled = YES;
            [self.payButton setTitle:@"Contact requester" forState:UIControlStateNormal];
            [self.payButton setBackgroundColor:[UIColor colorWithRed:0.9 green:0.3 blue:0 alpha:1.0]];
            [self.payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        } else {
            self.payButton.hidden = YES;
            self.payButton.userInteractionEnabled = NO;
        }
    } else {
        self.payButton.hidden = YES;
        self.payButton.userInteractionEnabled = NO;
    }
    
    
    
    
}

- (void) showPayLabel {
    PFUser *requester = self.task[@"requester"];
    PFUser *missioner = self.task[@"missioner"];
    NSDate *completedAt = self.task[@"completedAt"];
    NSDate *paidAt = self.task[@"paidAt"];
    
    if (!missioner || [missioner isEqual:[NSNull null]]) {
        self.payLabel.text = @"Still awaiting for a missioner!!";
        self.payLabel.textColor = [UIColor grayColor];
    } else if (!completedAt) {
        self.payLabel.text = [NSString stringWithFormat:@"Still in progress by missioner @%@...", missioner[@"username"]];
        self.payLabel.textColor = [UIColor grayColor];
    } else if (!paidAt) {
        self.payLabel.text = [NSString stringWithFormat:@"Still awaiting pay from requester @%@...", requester[@"username"]];
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
    UIButton *btn = (UIButton *) sender;
    if (btn.hidden == NO) {
        if ([btn.currentTitle isEqualToString:@"Accept"]) {
            PFUser *user = [PFUser currentUser];
            self.task[@"missioner"] = user;
            self.task[@"acceptedAt"] = [NSDate date];
            self.task[@"completionStatus"] = @"accepted";
            [self.task saveInBackground];
            [self updateView];
        } else if ([btn.currentTitle isEqualToString:@"Cancel"]) {
            self.task[@"missioner"] = [NSNull null];
            self.task[@"acceptedAt"] = [NSNull null];
            self.task[@"completionStatus"] = @"created";
            [self.task saveInBackground];
            [self updateView];
        }
    }
    
}

- (IBAction)onTapCompleteButton:(id)sender {
    UIButton *btn = (UIButton *) sender;
    if (btn.hidden == NO && [btn.currentTitle isEqualToString:@"Complete"]) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Confirm Completion of Mission"
                                                                       message:@"Are you sure that you have completed the Mission?\nOnce confirmed you will no longer be able to change the status!"
                                                                preferredStyle:(UIAlertControllerStyleAlert)];
        
        // create an OK action
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Confirm"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             NSLog(@"completedConfirmed");
                                                             self.task[@"completedAt"] = [NSDate date];
                                                             self.task[@"completionStatus"] = @"completed";
                                                             [self.task saveInBackground];
                                                             [self updateView];
                                                         }];
        UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             NSLog(@"cancelCompletion");
                                                         }];
        [alert addAction:okAction];
        [alert addAction:noAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    
    
    
}
- (IBAction)onTapPayButton:(id)sender {
}

- (void) updateView {
    [self showAcceptButton];
    [self showAcceptLabel];
    [self showCompleteLabel];
    [self showPayLabel];
    [self showCompleteButton];
    [self showPayButton];
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
