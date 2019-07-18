//
//  EditProfileViewController.m
//  TaskU
//
//  Created by panzaldo on 7/17/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "EditProfileViewController.h"
#import <Parse/Parse.h>
#import "Task.h"
#import <UIKit/UIKit.h>


@interface EditProfileViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *editedName;
@property (weak, nonatomic) IBOutlet UITextField *editedEmail;
@property (weak, nonatomic) IBOutlet UITextField *editedUsername;
@property (weak, nonatomic) IBOutlet UITextField *editedPhone;
@property (weak, nonatomic) IBOutlet UITextField *editedUniversity;
//@property (weak, nonatomic) IBOutlet UIImageView *chosenImageView;
@property (strong, nonatomic) UIImage *chosenImage;


@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    // Resize the image
   // self.chosenImageView.image = editedImage;
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


- (IBAction)onTapChooseImage:(UIButton *)sender {
    [self chooseImage];
}

- (IBAction)onSave:(UIButton *)sender {
    PFUser *user = [PFUser currentUser];
    user.username = self.editedUsername.text;
    user[@"name"] = self.editedName.text;
    user[@"phone"] = self.editedName.text;
    user[@"university"] = self.editedName.text;
    user[@"profileImage"] = [Task getPFFileFromImage:self.chosenImage];
    [user saveInBackground];
    [self dismissViewControllerAnimated:YES completion:^{}];
    
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
