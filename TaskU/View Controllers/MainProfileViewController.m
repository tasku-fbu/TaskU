//
//  MainProfileViewController.m
//  TaskU
//
//  Created by panzaldo on 7/18/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "MainProfileViewController.h"
#import "Task.h"
#import <Parse/Parse.h>
#import "UIImageView+AFNetworking.h"
#import "EditProfileViewController.h"
#import "ProfileViewController.h"

@interface MainProfileViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userProfileImage;

//@property (weak, nonatomic) EditProfileViewController *editProfileViewController;

@end

@implementation MainProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  self.tableView.rowHeight = 44;
    [self fetchProfileImage];
    
  //  self.editProfileViewController = [[EditProfileViewController alloc] init];

    //Setting the delegate 
    //self.editProfileViewController.delegate = self;
    
    //EditProfileViewController *vc = [[EditProfileViewController alloc] init];
  //  vc.delegate = self;
    [self.tableView reloadData];

}


-(void)fetchProfileImage{
    PFUser *user = [PFUser currentUser];
    self.nameLabel.text = user[@"firstName"];
    //Set profile image
    PFFileObject *imageFile = user[@"profileImage"];
    
    NSString *urlString = imageFile.url;
    [self.userProfileImage setImageWithURL:[NSURL URLWithString:urlString]];
    
    self.userProfileImage.layer.cornerRadius = 40;
    self.userProfileImage.clipsToBounds = YES;
}

//Delegate methid
- (void)didEditProfilewithImage:(nonnull UIImage *)image {
    NSLog(@"didEditProfile");
    PFUser *user = [PFUser currentUser];
    [self.userProfileImage setImage:image];
    self.nameLabel.text = user[@"firstName"];
    [self.tableView reloadData];

}

- (IBAction)unwindToProfile:(UIStoryboardSegue *)unwindSegue
{
        UIViewController* sourceViewController = unwindSegue.sourceViewController;

        if ([sourceViewController isKindOfClass:[EditProfileViewController class]])
        {
            NSLog(@"Coming from Editing Profile!");
        }
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"editProfile"]) {
        ProfileViewController *profilevc = [segue destinationViewController];
        profilevc.mainProfileVC = self;
    }
    
}

@end

