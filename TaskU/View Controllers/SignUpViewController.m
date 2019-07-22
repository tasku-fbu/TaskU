//
//  SignUpViewController.m
//  TaskU
//
//  Created by rhaypapenfuzz on 7/15/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "SignUpViewController.h"
#import "Parse/Parse.h"
#import "Task.h"

@interface SignUpViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *universityNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property NSUInteger phoneNumberLength;
@property (weak, nonatomic) IBOutlet UIImageView *userProfileImage;
@end

@interface NSString (emailValidation)
- (BOOL)isValidEmail;
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
    newUser[@"firstName"] = self.firstNameTextField.text;
    newUser[@"lastName"] = self.lastNameTextField.text;
    newUser[@"university"] = self.universityNameTextField.text;
    newUser[@"phoneNumber"] = self.phoneNumberTextField.text;
    

    PFFileObject *userImage = newUser[@"profilePic"];
    userImage  = [Task getPFFileFromImage: self.userProfileImage.image];
    [newUser setObject:userImage forKey:@"profileImage"];
    
    [newUser saveInBackground];
    
    self.phoneNumberLength = [self.phoneNumberTextField.text length];
    
    if([self.emailTextField.text isValidEmail]) {
        /* True */
        NSLog(@"Valid Email");
    }
    //if([self.emailTextField.text isValidEmail]) {
        /* False */
      //  NSLog(@"Invalid Email");
    //}
    // set user properties
    if ([self isSignUpInfoComplete] == false){
        
        //show alert
        
    }
    else{
        // call sign up function on the object
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
            if (error != nil) {
                NSLog(@"Error: %@", error.localizedDescription);
            } else {
                NSLog(@"User registered successfully");
                
                [newUser saveInBackground];
                // dismiss signUpViewController
                [self dismissViewControllerAnimated:true completion:nil];
            }
        }];
    }
}

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}


//Alerts the user if unaccepted sign up information is entered
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
    else if ([self.firstNameTextField.text isEqual:@""] || [self.lastNameTextField.text isEqual:@""]){
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid name"
                                                                       message:@"Please type a valid name."
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
    else if (self.phoneNumberLength < 10) {
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid phone number"
                                                                       message:@"Must be more than 10 characters"
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
    
    else if ([self.emailTextField.text isEqual:@""]){
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid Email"
                                                                       message:@"Please type a valid email."
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
    
    else if ([self.universityNameTextField.text isEqual:@""]){
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid University"
                                                                       message:@"Please type your University name."
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
    else if ([self.confirmPasswordTextField.text isEqual:@""]){
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid Password"
                                                                       message:@"Both Passwords must match."
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
    else if (![self.confirmPasswordTextField.text isEqual:self.passwordTextField.text]){
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid Password"
                                                                       message:@"Both Passwords must match."
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

 #pragma mark - choosing image upload function
- (IBAction)chooseImageAction:(id)sender {
    //Instantiating a UIImagePickerController
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera is not available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:imagePickerVC animated:YES completion:nil];
    
}

 #pragma mark - // implementation of the imagePickerController delegate method
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Gets the image captured by the UIImagePickerController
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    self.userProfileImage.image = editedImage;  //set selected image in uiview to edited image
    
    // Dismiss UIImagePickerController to go back to your original view controller
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
