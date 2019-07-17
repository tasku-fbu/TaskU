//
//  LoginViewController.M
//  TaskU
//
//  Created by rhaypapenfuzz on 7/15/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"

#import "Timeline1ViewController.h"

static NSString *const signUpSegueIdentifier = @"signUpSegue";
static NSString *const loginSegueIdentifier = @"loginSegue";

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

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

- (IBAction)signUpButtonAction:(id)sender {
    [self performSegueWithIdentifier: signUpSegueIdentifier sender:nil]; //performs segue to show sign up page
}
- (IBAction)loginActionButton:(id)sender {
    [self loginUser]; //verifies the user through parse login authentication
}



//Alerts the user if unaccepted login information is entered
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
- (IBAction)test:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Timeline1" bundle:nil];
    Timeline1ViewController *myNewVC = (Timeline1ViewController *) [storyboard instantiateViewControllerWithIdentifier:@"Timeline1"];
    UIViewController *vc = (UIViewController *) self;
    [vc presentViewController:myNewVC animated:YES completion:nil];

}



@end
