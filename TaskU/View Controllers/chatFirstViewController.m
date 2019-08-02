//
//  chatFirstViewController.m
//  TaskU
//
//  Created by lucyyyw on 8/1/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "chatFirstViewController.h"

@interface chatFirstViewController ()

@end

@implementation chatFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UINavigationBar *bar = [self.navigationController navigationBar];
    [bar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [bar setShadowImage:[[UIImage alloc] init]];
    [bar setBarTintColor:[UIColor colorWithRed:56/255.0 green:151.0/255 blue:240/255.0 alpha:1.0]];
    bar.translucent = false;
    bar.backgroundColor = [UIColor colorWithRed:56/255.0 green:151.0/255 blue:240/255.0 alpha:1.0];
    [bar setValue:@(YES) forKeyPath:@"hidesShadow"];
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName:[UIFont fontWithName:@"Quicksand-Bold" size:20]}];
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
