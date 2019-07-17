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
    
    [Task postTask:self.taskName.text withStart:self.startAddress.text withDate:self.taskDate.date withDifficulty:self.taskSize.text withDescription:self.taskDescription.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        
        if(succeeded){
            NSLog(@"Posted!");
            [self dismissViewControllerAnimated:YES completion:nil];

            //ParentViewController is tab bar controller
           // [self.parentViewController.tabBarController setSelectedIndex:0];
        } else{
            NSLog(@"Error posting task: %@", error.localizedDescription);
            
        }
}];
    
//    [Task postTask:self.taskName.text withStart:self._startAddress.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
//
//        if(succeeded){
//            NSLog(@"Posted!");
//            //ParentViewController is tab bar controller
//            [self.parentViewController.tabBarController setSelectedIndex:0];
//        } else{
//            NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
//
//        }
//
//    }];
//    + (void) postTask: ( NSString * _Nullable )taskName withStart: ( PFGeoPoint * _Nullable )startAddress withDate: (NSDate *_Nullable)taskDate withDifficulty: ( NSString * _Nullable )taskDifficulty withDescription: ( NSString * _Nullable )taskDescription withCompletion: (PFBooleanResultBlock  _Nullable)completion
    [self dismissViewControllerAnimated:YES completion:nil];

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
