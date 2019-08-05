//
//  EditProfileViewController.m
//  TaskU
//
//  Created by panzaldo on 7/17/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "EditProfileViewController.h"
//#import "MapViewController.h"
#import "SWRevealViewController.h"
#import <Parse/Parse.h>
#import <Photos/Photos.h>
#import "Task.h"
#import <UIKit/UIKit.h>


@interface EditProfileViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *editedName;
@property (weak, nonatomic) IBOutlet UITextField *editedLastName;
@property (weak, nonatomic) IBOutlet UITextField *editedEmail;
@property (weak, nonatomic) IBOutlet UITextField *editedUsername;
@property (weak, nonatomic) IBOutlet UITextField *editedPhone;
@property (weak, nonatomic) IBOutlet UITextField *editedUniversity;
@property (strong, nonatomic) UIImage *chosenImage;

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Sets side navigation
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sideButton setTarget: self.revealViewController];
        [self.sideButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }

    //Load and display current user info
    PFUser *user = [PFUser currentUser];
    
    //User can modify first and last name
    self.editedName.text = user[@"firstName"];
    self.editedLastName.text = user[@"lastName"];
    self.editedEmail.text = user[@"email"];
    self.editedUsername.text = user.username;
    self.editedPhone.text = [user[@"phone"] stringValue];
    self.editedUniversity.text = user[@"university"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 45; // Something reasonable to help ios render your cells
   // self.tableView.rowHeight = 44;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    // Resize the image
    self.chosenImage = [self resizeImage:editedImage withSize:CGSizeMake(400, 400)];
    
    // Dismiss UIImagePickerController to go back to Home View controller
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//Resize the UIImage (Parse has a limit of 10MB for uploading photos)
- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


-(void)chooseImage{
    // Instantiate a UIImagePickerController
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    //imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    // If camera is available, choose camera. Else, choose camera roll
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
    }
    [self presentViewController:imagePickerVC animated:YES completion:^{
    }];
}




//Sends updated user info to Parse
-(void)updateUserInfo{
    PFUser *user = [PFUser currentUser];
    user[@"firstName"] = self.editedName.text;
    user[@"lastName"] = self.editedLastName.text;
    user[@"email"] = self.editedEmail.text;
    user.username = self.editedUsername.text;
    user[@"phone"] = [NSNumber numberWithInt:[self.editedPhone.text intValue]];
    user[@"university"] = self.editedUniversity.text;
    //TODO: Place some image here
    if (self.chosenImage) {
        user[@"profileImage"] = [Task getPFFileFromImage:self.chosenImage];
        [self.delegate didEditProfilewithImage:self.chosenImage];
    }
    [self.delegate didEditProfileName];
    [user saveInBackground];
    

//    [self.delegate didEditProfilewithImage:self.chosenImage];
    
    //[user saveInBackground];
    
    
 [self performSegueWithIdentifier:@"UnwindToProfileID" sender:self];

    NSLog(@"Am I saving this picture?");
}

- (IBAction)onTapChooseImage:(UIButton *)sender {
    [self chooseImage];
}

- (IBAction)onSave:(UIButton *)sender {
    [self updateUserInfo];

}

- (IBAction)onTapCash:(UIButton *)sender {
    // Call the Cash App app from TaskU
    
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:@"squarecash://"];
    [application openURL:URL options:@{} completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"Opened url");
        }
    }];
     
    
}


@end

