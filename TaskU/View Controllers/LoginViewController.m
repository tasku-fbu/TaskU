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
    
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            [self performSegueWithIdentifier: loginSegueIdentifier sender:nil]; //performs segue to login if user is valid
            NSLog(@"User logged in successfully");
            
            // display view controller that needs to shown after successful login
        }
    }];
}

- (IBAction)signUpButtonAction:(id)sender {
     [self performSegueWithIdentifier: signUpSegueIdentifier sender:nil]; //performs segue to show sign up page
}
- (IBAction)loginActionButton:(id)sender {
    [self loginUser]; //verifies the user through parse login authentication
}


- (IBAction)onTestTimeline1:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Timeline1" bundle:nil];
    Timeline1ViewController *myNewVC = (Timeline1ViewController *) [storyboard instantiateViewControllerWithIdentifier:@"Timeline1ViewController"];
    UIViewController *vc = (UIViewController *) self;
    [vc presentViewController:myNewVC animated:YES completion:nil];
}

@end
