//
//  SignUpViewController.m
//  TaskU
//
//  Created by rhaypapenfuzz on 7/15/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "SignUpViewController.h"
#import "Parse/Parse.h"

@interface SignUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *universityNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;


@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)cancelButtonAction:(id)sender {
     [self dismissViewControllerAnimated:true completion:nil];
}
- (IBAction)signUpButtonAction:(id)sender {
    
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.usernameTextField.text;
    newUser.email = self.emailTextField.text;
    newUser.password = self.passwordTextField.text;
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
            PFUser *user = [PFUser currentUser];
            user[@"name"] = self.universityNameTextField.text;
            user[@"university"] = self.universityNameTextField.text;
            user[@"phone"] = self.phoneNumberTextField.text;
            NSString *confirmPassword =  self.confirmPasswordTextField.text;
            [user saveInBackground];
            // dismiss signUpViewController
            [self dismissViewControllerAnimated:true completion:nil];
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
