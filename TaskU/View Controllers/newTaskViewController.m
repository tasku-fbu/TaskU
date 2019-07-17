//
//  newTaskViewController.m
//  TaskU
//
//  Created by panzaldo on 7/16/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "newTaskViewController.h"
#import "Task.h"

@interface newTaskViewController ()
@property (weak, nonatomic) IBOutlet UITextField *taskName;
@property (weak, nonatomic) IBOutlet UITextField *startAddress;
@property (weak, nonatomic) IBOutlet UITextField *endAddress;
@property (weak, nonatomic) IBOutlet UIDatePicker *taskDate;
@property (weak, nonatomic) IBOutlet UITextField *taskSize;
@property (weak, nonatomic) IBOutlet UITextField *taskDescription;

@end

@implementation newTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)didTapClose:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)didTapNext:(UIButton *)sender {
    [Task postTask:self.taskName.text withStart:self.startAddress.text withEnd:self.endAddress.text withDate:self.taskDate.date withDifficulty:self.taskSize.text withDescription:self.taskDescription.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        
        if(succeeded){
            NSLog(@"Posted!");
            [self dismissViewControllerAnimated:YES completion:nil];

            //ParentViewController is tab bar controller
           // [self.parentViewController.tabBarController setSelectedIndex:0];
        } else{
            NSLog(@"Error posting task: %@", error.localizedDescription);
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Completion error"
                                                                           message:@"Please fill all the required fields"
                                                                    preferredStyle:(UIAlertControllerStyleAlert)];

            // create an OK action
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 // handle response here.
                                                             }];
            // add the OK action to the alert controller
            [alert addAction:okAction];
            
        }
    }];
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
