//
//  newTaskViewController.m
//  TaskU
//
//  Created by panzaldo on 7/16/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "newTaskViewController.h"
#import "Task.h"

@interface newTaskViewController () <UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *taskName;
@property (weak, nonatomic) IBOutlet UITextField *startAddress;
@property (weak, nonatomic) IBOutlet UITextField *endAddress;
@property (weak, nonatomic) IBOutlet UIDatePicker *taskDate;
//@property (weak, nonatomic) IBOutlet UITextField *taskSize;
@property (weak, nonatomic) IBOutlet UITextField *taskDescription;
@property (weak, nonatomic) IBOutlet UITextField *hours;
@property (weak, nonatomic) IBOutlet UITextField *minutes;
@property (weak, nonatomic) IBOutlet UITextField *payAmount;
@property (strong, nonatomic) UIAlertController *completionAlert;
@property (strong, nonatomic) UIAlertController *networkAlert;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (strong, nonatomic) NSArray *categories;
@property (strong, nonatomic) NSString *chosenCategory;


@end

@implementation newTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Alert for incomplete user input
    self.completionAlert = [UIAlertController alertControllerWithTitle:@"Error"
                                                     message:@"Please input all the required fields"
                                              preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *errorAction = [UIAlertAction actionWithTitle:@"Ok"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                        }];
    [self.completionAlert addAction:errorAction];
    
    
    //Alert for Network Error
    self.networkAlert = [UIAlertController alertControllerWithTitle:@"Network Error"
                                                               message:@"Please connect to the internet"
                                                        preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *otherErrorAction = [UIAlertAction actionWithTitle:@"Ok"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                        }];
    // add the OK action to the alert controller
    [self.networkAlert addAction:otherErrorAction];
    
    // Connect data:
    self.picker.delegate = self;
    self.picker.dataSource = self;
    
    //Task Categories
    self.categories = @[@"Delivery", @"Groceries", @"Laundry and Cleaning", @"Tutoring", @"Volunteering", @"Other"];

}


-(void)makePost {
    //NSSet of erroneus hour/minute times and pay (empty field or 0)
    NSSet *errorAmount = [NSSet setWithObjects:@"", @"0", nil];
    
    //Payment can't be empty, but can be 0
    NSSet *zeroPayAmount = [NSSet setWithObjects:@"", nil];


    //Checks if one of the required fields is empty. Only optional field is Start Address
    if ([self.taskName.text isEqualToString:@""] || [self.endAddress.text isEqualToString:@""] || [self.taskDescription.text isEqualToString:@""] || [zeroPayAmount containsObject:self.payAmount.text] || ([errorAmount containsObject:self.minutes.text] && [errorAmount containsObject:self.hours.text])){
        [self presentViewController:self.completionAlert animated:YES completion:^{
        }];
    } else {
        [Task postTask:self.taskName.text withStart:self.startAddress.text withEnd:self.endAddress.text withCategory: self.chosenCategory withDate:self.taskDate.date withHours:self.hours.text withMinutes:self.minutes.text withPay:self.payAmount.text withDescription:self.taskDescription.text withCompletion:^(BOOL succeeded, NSError * _Nullable error){
            
            if(succeeded){
                NSLog(@"Posted!");
                [self dismissViewControllerAnimated:YES completion:nil];
                
                //TODO: Incorporate connection to tab bar controller
                //ParentViewController is tab bar controller
                // [self.parentViewController.tabBarController setSelectedIndex:0];
            } else{
                NSLog(@"Error posting task: %@", error.localizedDescription);
                [self presentViewController:self.networkAlert animated:YES completion:^{
                }];
            }
        }];
    }
}




- (IBAction)didTapClose:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)didTapNext:(UIButton *)sender {
    [self makePost];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView { 
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component { 
    return self.categories.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.categories[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.chosenCategory = [self.categories objectAtIndex:row];
}

@end
