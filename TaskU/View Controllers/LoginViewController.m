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
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
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

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
}
/*
#pragma mark - keyboard movements
- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = -keyboardSize.height;
        self.view.frame = f;
    }];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = 0.0f;
        self.view.frame = f;
    }];
}*/
/*
- (void)registerForKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

- (void)deregisterFromKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self registerForKeyboardNotifications];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [self deregisterFromKeyboardNotifications];
    
    [super viewWillDisappear:animated];
    
}

- (void)keyboardWasShown:(NSNotification *)notification {
    
    NSDictionary* info = [notification userInfo];
    
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGPoint buttonOrigin = self.loginButton.frame.origin;
    
    CGFloat buttonHeight = self.loginButton.frame.size.height;
    
    CGRect visibleRect = self.view.frame;
    
    visibleRect.size.height -= keyboardSize.height;
    
    if (!CGRectContainsPoint(visibleRect, buttonOrigin)){
        
        CGPoint scrollPoint = CGPointMake(0.0, buttonOrigin.y - visibleRect.size.height + buttonHeight);
        
        [self.scrollView setContentOffset:scrollPoint animated:YES];
        
    }
    
}

- (void)keyboardWillBeHidden:(NSNotification *)notification {
    
    [self.scrollView setContentOffset:CGPointZero animated:YES];
    
}*/
@end
