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
    
   // NSArray *pickerData;
    // Input the data into the array
  //  pickerData = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6"];
    
}


-(void)makePost {
    //NSSet of erroneus hour/minute times and pay (empty field or 0)
    NSSet *errorAmount = [NSSet setWithObjects:@"", @"0", nil];

    //Checks if one of the required fields is empty. Only optional field is Start Address
    if ([self.taskName.text isEqualToString:@""] || [self.endAddress.text isEqualToString:@""] || [self.taskDescription.text isEqualToString:@""] || [errorAmount containsObject:self.payAmount.text] || ([errorAmount containsObject:self.minutes.text] && [errorAmount containsObject:self.hours.text])){
        [self presentViewController:self.completionAlert animated:YES completion:^{
        }];
    } else {
        [Task postTask:self.taskName.text withStart:self.startAddress.text withEnd:self.endAddress.text withDate:self.taskDate.date withHours:self.hours.text withMinutes:self.minutes.text withPay:self.payAmount.text withDescription:self.taskDescription.text withCompletion:^(BOOL succeeded, NSError * _Nullable error){
            
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
    <#code#>
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component { 
    <#code#>
}

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder { 
    <#code#>
}

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection { 
    <#code#>
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container { 
    <#code#>
}

- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize { 
    <#code#>
}

- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container { 
    <#code#>
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator { 
    <#code#>
}

- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator { 
    <#code#>
}

- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator { 
    <#code#>
}

- (void)setNeedsFocusUpdate { 
    <#code#>
}

- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context { 
    <#code#>
}

- (void)updateFocusIfNeeded { 
    <#code#>
}

@end
