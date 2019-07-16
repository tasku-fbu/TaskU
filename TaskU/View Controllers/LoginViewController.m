//
//  LoginViewController.M
//  TaskU
//
//  Created by rhaypapenfuzz on 7/15/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "LoginViewController.h"

static NSString *const signUpSegueIdentifier = @"signUpSegue";
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)signUpButtonAction:(id)sender {
     [self performSegueWithIdentifier: signUpSegueIdentifier sender:nil]; //performs segue to show sign up page
}

@end
