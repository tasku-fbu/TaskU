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

@interface MainProfileViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userProfileImage;

@end

@implementation MainProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PFUser *user = [PFUser currentUser];
    self.nameLabel.text = user[@"firstName"];
    
    //  self.tableView.rowHeight = 44;
    [self fetchProfileImage];
    
    
    //EditProfileViewController *vc = [[EditProfileViewController alloc] init];
  //  vc.delegate = self;
    //[self.tableView reloadData];

}


-(void)fetchProfileImage{
    PFUser *user = [PFUser currentUser];

    //Set profile image
    PFFileObject *imageFile = user[@"profileImage"];
    
    NSString *urlString = imageFile.url;
    [self.userProfileImage setImageWithURL:[NSURL URLWithString:urlString]];
    
    self.userProfileImage.layer.cornerRadius = 40;
    self.userProfileImage.clipsToBounds = YES;
}

//Protocol
- (void)didEditProfilewithImage:(nonnull UIImage *)image {
    [self.userProfileImage setImage:image];

}

- (IBAction)unwindToProfile:(UIStoryboardSegue *)unwindSegue
{
        UIViewController* sourceViewController = unwindSegue.sourceViewController;

        if ([sourceViewController isKindOfClass:[EditProfileViewController class]])
        {
            NSLog(@"Coming from Editing Profile!");

        }
    
}

@end

