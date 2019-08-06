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
#import "AppDelegate.h"
#import "LoginViewController.h"

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
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor blackColor],
       NSFontAttributeName:[UIFont fontWithName:@"Quicksand-Bold" size:19]}];
    [self.tableView reloadData];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 100)];
    
    [self.tableView setTableFooterView:view];
    
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

- (void) didEditProfileName {
    PFUser *user = [PFUser currentUser];
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

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        appDelegate.window.rootViewController = loginViewController;
        
        
        [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
            // PFUser.current() will now be nil
        }];

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

