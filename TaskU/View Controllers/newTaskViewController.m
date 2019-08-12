//
//  newTaskViewController.m
//  TaskU
//
//  Created by panzaldo on 7/16/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "newTaskViewController.h"
#import "Task.h"
#import "LocationsViewController.h"
#import "newTaskViewController.h"
#import "CustomAlert.h"

@interface newTaskViewController () <UIPickerViewDelegate, UIPickerViewDataSource, LocationsViewControllerDelegate>
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
@property (strong, nonatomic) NSNumber *startLatitude;
@property (strong, nonatomic) NSNumber *startLongitude;
@property (strong, nonatomic) NSNumber *endLatitude;
@property (strong, nonatomic) NSNumber *endLongitude;
@property (assign, nonatomic) BOOL isThisStartAddress;
@property(strong,nonatomic) CustomAlert *customAlert;
@end

static NSString *const addressSegueIdentifier = @"addressSegue";
@implementation newTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor blackColor],
       NSFontAttributeName:[UIFont fontWithName:@"Quicksand-Bold" size:19]}];
    
    // Connect data:
    self.picker.delegate = self;
    self.picker.dataSource = self;
    
    //Task Categories
    self.categories = @[@"Delivery", @"Groceries", @"Laundry & Cleaning", @"Tutoring", @"Volunteering", @"Other"];

}
- (IBAction)startAddressAction:(id)sender {
    self.isThisStartAddress = TRUE;
    [self performSegueWithIdentifier: addressSegueIdentifier sender:nil]; //performs segue to LocationViewController

}
- (IBAction)endAddressAction:(id)sender {
     self.isThisStartAddress = FALSE;
     [self performSegueWithIdentifier: addressSegueIdentifier sender:nil]; //performs segue to LocationViewController
}
- (IBAction)clearStartAddress:(id)sender {
    self.startAddress.text = nil;
    self.startLatitude = nil;
    self.startLongitude = nil;
}
- (IBAction)clearEndAddress:(id)sender {
    self.endAddress.text = nil;
    self.endLatitude = nil;
    self.endLongitude = nil;
}

#pragma mark - Gets user selected location's name of place and address
- (void)locationsViewController:(nonnull LocationsViewController *)controller didPickLocationWithName:(nonnull NSString *) locationName address:(nonnull NSString *)locationAddress {
    if(self.isThisStartAddress){
        self.startAddress.text = locationName;
    }
    else
    {
        self.endAddress.text = locationName;
    }
    
}
#pragma mark - Gets user selected location's coordinates and resets annotation
- (void)locationsViewController:(nonnull LocationsViewController *)controller didPickLocationWithLatitude:(nonnull NSNumber *)latitude longitude:(nonnull NSNumber *)longitude {
     NSLog( @"Location latitude is: %@. Location longitude is: %@",latitude, longitude);
    if(self.isThisStartAddress) {
       self.startLatitude = latitude;
       self.startLongitude = longitude;
    }
    else{
        self.endLatitude = latitude;
        self.endLongitude = longitude;
    }

}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:addressSegueIdentifier]) {
        LocationsViewController *locationVC = [segue destinationViewController];
        //editVC.delegate = self.mainProfileVC;
        locationVC.isNewTaskViewController = TRUE;
        locationVC.delegate = self;
    }
}
-(void)makePost {
    //NSSet of erroneus hour/minute times and pay (empty field or 0)
    NSSet *errorAmount = [NSSet setWithObjects:@"", @"0", nil];
    
    //Payment can't be empty, but can be 0
    NSSet *zeroPayAmount = [NSSet setWithObjects:@"", nil];


    //Checks if one of the required fields is empty. Only optional field is Start Address
    if ([self.taskName.text isEqualToString:@""] || [self.endAddress.text isEqualToString:@""] || [self.taskDescription.text isEqualToString:@""] || [zeroPayAmount containsObject:self.payAmount.text] || ([errorAmount containsObject:self.minutes.text] && [errorAmount containsObject:self.hours.text])){
        //Alert for incomplete user input
        
        self.customAlert = [[CustomAlert alloc] init];
        [self.customAlert showAlert:@"Error" withMessage:@"Please input all the required fields." withAlert:@"failure"];
        self.customAlert.buttonDelegate = self;
    } else {
        NSLog(@"%@ %@ %@ %@",self.startLatitude , self.startLongitude, self.endLatitude, self.endLongitude);
        [Task postTask:self.taskName.text withStart:self.startAddress.text withEnd:self.endAddress.text
         withStartLatitude:self.startLatitude withStartLongitude:self.startLongitude withEndLatitude:self.endLatitude withEndLongitude:self.endLongitude
          withCategory: self.chosenCategory withDate:self.taskDate.date withHours:self.hours.text withMinutes:self.minutes.text withPay:self.payAmount.text withDescription:self.taskDescription.text withCompletion:^(BOOL succeeded, NSError * _Nullable error){
            
            if(succeeded){
                NSLog(@"Posted!");
                self.customAlert = [[CustomAlert alloc] init];
                [self.customAlert showAlert:@"Success!" withMessage:@"Your task has succesfully posted." withAlert:@"success"];
                self.customAlert.buttonDelegate = self;
            } else{
                //Network Error
                self.customAlert = [[CustomAlert alloc] init];
                [self.customAlert showAlert:@"Error posting task" withMessage:@"Please connect to the internet." withAlert:@"failure"];
                self.customAlert.buttonDelegate = self;
                NSLog(@"Error posting task: %@", error.localizedDescription);

   
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

-(void)didTapButton{
    [self.customAlert.alertView removeFromSuperview];
    [self.customAlert.parentView removeFromSuperview];
    if([self.customAlert.doneButton.backgroundColor isEqual:[UIColor colorNamed:@"darkGreen"]]){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
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
