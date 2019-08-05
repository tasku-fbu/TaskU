//
//  LoginViewController.M
//  TaskU
//
//  Created by rhaypapenfuzz on 7/15/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"

#pragma mark - interface and properties
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

static NSString *const signUpSegueIdentifier = @"signUpSegue";
static NSString *const loginSegueIdentifier = @"loginSegue";

@implementation LoginViewController
@synthesize usernameTextField;

#pragma mark - Login Initial View
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    self.loginButton.layer.cornerRadius = 10;
    self.usernameTextField.layer.cornerRadius = 10;
    self.passwordTextField.layer.cornerRadius = 10;

}

#pragma mark - configuration for external touch and keyboard return key as user logs in
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    return true;
}
- (IBAction)didTapOutsideTextField:(id)sender {
    [self.view endEditing:YES];
}

#pragma mark - login verification block
- (void)loginUser {
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    
    
    if ([self isSignUpInfoComplete] == false){
        
        //show alert
        
    }
    else{
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
            if (error != nil) {
                NSLog(@"User log in failed: %@", error.localizedDescription);
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Try Again"
                                                                               message:@"Incorrect username or password"
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];
                
                // create an OK action
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                                   style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction * _Nonnull action) {
                                                                     // handle response here.
                                                                 }];
                // add the OK action to the alert controller
                [alert addAction:okAction];
                
                [self presentViewController:alert animated:YES completion:^{
                    // optional code for what happens after the alert controller has finished presenting
                }];
            } else {
                [self performSegueWithIdentifier: loginSegueIdentifier sender:nil]; //performs segue to login if user is valid
                NSLog(@"User logged in successfully");
                
                // display view controller that needs to shown after successful login
            }
        }];
    }
}

#pragma mark - buttons to login or move to sign up page
- (IBAction)signUpButtonAction:(id)sender {
    [self performSegueWithIdentifier: signUpSegueIdentifier sender:nil]; //performs segue to show sign up page
}
- (IBAction)loginActionButton:(id)sender {
    [self loginUser]; //verifies the user through parse login authentication
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //allows user to continue typing password from where they left
    NSString *updatedString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    textField.text = updatedString;
    
    return NO;
}

#pragma mark - user alerts during login if login information doesn't meet our standards
- (bool) isSignUpInfoComplete{
    
    if ([self.usernameTextField.text isEqual:@""]){
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid Username"
                                                                       message:@"Please type valid username."
                                                                preferredStyle:(UIAlertControllerStyleAlert)];
        
        // create an OK action
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             // handle response here.
                                                         }];
        // add the OK action to the alert controller
        [alert addAction:okAction];
        
        [self presentViewController:alert animated:YES completion:^{
            // optional code for what happens after the alert controller has finished presenting
        }];
        return false;
        
    }
    
    else if ([self.passwordTextField.text isEqual:@""]){
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid Password"
                                                                       message:@"Password cannot be empty."
                                                                preferredStyle:(UIAlertControllerStyleAlert)];
        
        // create an OK action
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             // handle response here.
                                                         }];
        // add the OK action to the alert controller
        [alert addAction:okAction];
        
        [self presentViewController:alert animated:YES completion:^{
            // optional code for what happens after the alert controller has finished presenting
        }];
        return false;
        
    }
    
    return true;
}



@end
