//
//  DetailsViewController.m
//  TaskU
//
//  Created by lucyyyw on 7/17/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "DetailsViewController.h"


@interface DetailsViewController ()


@end

@implementation DetailsViewController
- (void) viewDidLoad {
    [super viewDidLoad];
    //setting navigation bar
    UINavigationBar *bar = [self.navigationController navigationBar];
    [bar setBarTintColor:[UIColor colorWithRed:56/255.0 green:151.0/255 blue:240/255.0 alpha:1.0]];
    bar.translucent = false;
    bar.backgroundColor = [UIColor colorWithRed:56/255.0 green:151.0/255 blue:240/255.0 alpha:1.0];
    [bar setValue:@(YES) forKeyPath:@"hidesShadow"];
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName:[UIFont fontWithName:@"Quicksand-Bold" size:20]}];
}

- (IBAction)onTapBack:(id)sender {
    NSLog(@"on back");
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
