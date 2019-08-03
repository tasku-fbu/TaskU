//
//  ChooseLocationPopUpViewController.m
//  TaskU
//
//  Created by rhaypapenfuzz on 8/1/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "ChooseLocationPopUpViewController.h"
#import "Parse/Parse.h"
#import "HomeViewController.h"

@interface ChooseLocationPopUpViewController ()
@property (strong, nonatomic) UIAlertController *completionCityAlert;
@property (strong, nonatomic) UIAlertController *completionStateAlert;
@end

@implementation ChooseLocationPopUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Alert for incomplete user input
    self.completionCityAlert = [UIAlertController alertControllerWithTitle:@"Error"
                                                               message:@"Please input a valid City"
                                                        preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *errorAction = [UIAlertAction actionWithTitle:@"Ok"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                        }];
    [self.completionCityAlert addAction:errorAction];
    self.completionStateAlert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:@"Please input a valid State"
                                                            preferredStyle:(UIAlertControllerStyleAlert)];
    [self.completionStateAlert addAction:errorAction];
    
    
}

- (IBAction)closePopUpButtonAction:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)stateButtonAction:(id)sender {
    if ([self.stateTextField.text isEqualToString:@""]){
        [self presentViewController:self.completionStateAlert animated:YES completion:^{
        }];
    }
    else{
        PFUser *loggedInUser = [PFUser currentUser];
        loggedInUser[@"state"] = self.stateTextField.text;
        [self performSegueWithIdentifier:@"chooseCitySegue" sender:self];
    }
}

- (IBAction)saveButtonAction:(id)sender {
    // initialize a user object
        // call sign up function on the object
    if ([self.cityTextField.text isEqualToString:@""]){
        [self presentViewController:self.completionCityAlert animated:YES completion:^{
        }];
    }
    else {
        PFUser *loggedInUser = [PFUser currentUser];
        // set user properties
        loggedInUser[@"city"] = self.cityTextField.text;
        self.userLocation = [NSString stringWithFormat:@"%@, %@", loggedInUser[@"city"], loggedInUser[@"state"]];
        NSLog(@"%@",self.userLocation);
        //NSLog(@"City: %@, State: %@", loggedInUser[@"city"] ,loggedInUser[@"state"]);
        [loggedInUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if(succeeded){
              [self performSegueWithIdentifier:@"unwindToHome" sender:self];
            }
        }];
    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"unwindToHomeView"]) {
        HomeViewController *home = [segue destinationViewController];
        home.userLocation = sender;
    }
}
*/

@end
