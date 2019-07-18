//
//  HomeViewController.m
//  TaskU
//
//  Created by rhaypapenfuzz on 7/15/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "HomeViewController.h"
#import "ProfileViewController.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)dummyButton:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"newProfile" bundle:nil];
    ProfileViewController *myNewVC = (ProfileViewController *) [storyboard instantiateViewControllerWithIdentifier:@"newProfileViewController"];
    UIViewController *vc = (UIViewController *) self;
    [vc presentViewController:myNewVC animated:YES completion:nil];
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
