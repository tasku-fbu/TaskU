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

#pragma mark - interface and properties
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
@property (weak, nonatomic) IBOutlet UIButton *chooseImageButton;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (strong, nonatomic) CustomAlert *customAlert;


@end

@implementation SignUpViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Profile Image is hidden by default
    self.userProfileImage.hidden = YES;
    
    self.userProfileImage.layer.cornerRadius = 50;
    self.chooseImageButton.layer.cornerRadius = 50;
    self.signUpButton.layer.cornerRadius = 10;

}

#pragma mark - cancel returns user to login
- (IBAction)cancelButtonAction:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark - signup action
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
    
    
    self.phoneNumberLength = [self.phoneNumberTextField.text length];
    
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
                newUser[@"contacts"] = [NSArray new];
                
                PFACL *acl = [PFACL ACL];
                [acl setPublicReadAccess:true];
                [acl setPublicWriteAccess:true];
                
                newUser.ACL = acl;
                
                [newUser saveInBackground];
                
                // dismiss signUpViewController
                [self dismissViewControllerAnimated:true completion:nil];
            }
        }];
    }
}

#pragma mark - email validation format function for .edu ending
- (BOOL)validateEmail:(NSString *)userEmail {
    NSString *emailRegularExpression = @"[A-Z0-9a-z][A-Z0-9a-z._%+-]*@[A-Za-z0-9][A-Za-z0-9.-]*\\.[A-Za-z]{2,3}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegularExpression];
    NSRange aRange;
    if([emailTest evaluateWithObject:userEmail]) {
        aRange = [userEmail rangeOfString:@"." options:NSBackwardsSearch range:NSMakeRange(0, [userEmail length])];
        NSUInteger indexOfDot = aRange.location;
        if(aRange.location != NSNotFound) {
            NSString *topLevelDomain = [[userEmail substringFromIndex:indexOfDot] lowercaseString];
            
            if (topLevelDomain != nil && [topLevelDomain isEqualToString:@".edu"]){
                //NSLog(@"TLD contains topLevelDomain:%@",topLevelDomain);
                
                return TRUE;
            }
            
        }
    }
    return FALSE;
}

#pragma mark - user alerts during sign up if sign up information doesn't meet our standards
//Alerts the user if unaccepted sign up information is entered
- (bool) isSignUpInfoComplete{
    
    if ([self.usernameTextField.text isEqual:@""]){
        self.customAlert = [[CustomAlert alloc] init];
        [self.customAlert showAlert:@"Invalid Username" withMessage:@"Please type valid username." withAlert:@"failure"];
        self.customAlert.buttonDelegate = self;
        return false;
        
    }
    else if ([self.firstNameTextField.text isEqual:@""] || [self.lastNameTextField.text isEqual:@""]){
        self.customAlert = [[CustomAlert alloc] init];
        [self.customAlert showAlert:@"Invalid name" withMessage:@"Please type a valid name." withAlert:@"failure"];
        self.customAlert.buttonDelegate = self;
        return false;
    }
    else if (self.phoneNumberLength < 10) {
        
        self.customAlert = [[CustomAlert alloc] init];
        [self.customAlert showAlert:@"Invalid phone number" withMessage:@"Must be more than 10 characters." withAlert:@"failure"];
        self.customAlert.buttonDelegate = self;
        return false;
        
    }
    
    else if ([self.emailTextField.text isEqual:@""]){
        self.customAlert = [[CustomAlert alloc] init];
        [self.customAlert showAlert:@"Invalid Email" withMessage:@"Please type a valid email." withAlert:@"failure"];
        self.customAlert.buttonDelegate = self;
        return false;
    }
    else if(![self validateEmail:self.emailTextField.text]) {
        //Email Address is Invalid.
        //checks if the email follows the format name@something.edu
        self.customAlert = [[CustomAlert alloc] init];
        [self.customAlert showAlert:@"Invalid Email" withMessage:@"Use a valid .edu email." withAlert:@"failure"];
        self.customAlert.buttonDelegate = self;
        return false;
    }
    else if ([self.universityNameTextField.text isEqual:@""]){
        self.customAlert = [[CustomAlert alloc] init];
        [self.customAlert showAlert:@"Invalid University" withMessage:@"Please type your University name." withAlert:@"failure"];
        self.customAlert.buttonDelegate = self;
        return false;
    }
    else if ([self.passwordTextField.text isEqual:@""]){
        
        self.customAlert = [[CustomAlert alloc] init];
        [self.customAlert showAlert:@"Invalid Password" withMessage:@"Password cannot be empty." withAlert:@"failure"];
        self.customAlert.buttonDelegate = self;
        return false;
    }
    else if ([self.confirmPasswordTextField.text isEqual:@""]){
        self.customAlert = [[CustomAlert alloc] init];
        [self.customAlert showAlert:@"Invalid Password" withMessage:@"Both passwords must match." withAlert:@"failure"];
        self.customAlert.buttonDelegate = self;
        return false;
    }
    else if (![self.confirmPasswordTextField.text isEqual:self.passwordTextField.text]){
        self.customAlert = [[CustomAlert alloc] init];
        [self.customAlert showAlert:@"Invalid Password" withMessage:@"Both passwords must match." withAlert:@"failure"];
        self.customAlert.buttonDelegate = self;
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
- (IBAction)tapOutsideTextField:(id)sender {
    [self.view endEditing:YES];
}
#pragma mark - // implementation of the imagePickerController delegate method
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Gets the image captured by the UIImagePickerController
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    self.userProfileImage.image = editedImage;  //set selected image in uiview to edited image
    
    // Dismiss UIImagePickerController to go back to  original view controller
    self.userProfileImage.hidden = NO;

    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)didTapButton {
    [self.customAlert.alertView removeFromSuperview];
    [self.customAlert.parentView removeFromSuperview];
}

@end
