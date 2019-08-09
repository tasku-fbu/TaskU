//
//  MainTabViewController.m
//  TaskU
//
//  Created by lucyyyw on 8/9/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "MainTabViewController.h"
#import "VCTransitionsLibrary/CEPanAnimationController.h"


@interface MainTabViewController () 

@property (strong, nonatomic) CEPanAnimationController * animator;
@end

@implementation MainTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.animator = [[CEPanAnimationController alloc] init];
    self.delegate = self;
}

- (id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
            animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                              toViewController:(UIViewController *)toVC {
    
    NSUInteger fromVCIndex = [tabBarController.viewControllers indexOfObject:fromVC];
    NSUInteger toVCIndex = [tabBarController.viewControllers indexOfObject:toVC];
    self.animator.duration = 5;
    self.animator.reverse = fromVCIndex < toVCIndex;
    return self.animator;
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
