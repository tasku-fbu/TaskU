//
//  AppDelegate.m
//  TaskU
//
//  Created by rhaypapenfuzz on 7/15/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "AppDelegate.h"
#import "Parse/Parse.h"
#import "UIButtonExtension.h"
#import "IQKeyboardManager.h"
#import "MainTabViewController.h"
//#import "VCTransitionsLibrary/CEPanAnimationController.h"
#import "PanTabAnimator.h"

@interface AppDelegate () <UITabBarControllerDelegate>
@property (strong, nonatomic) PanTabAnimator * animator;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [UIButtonExtension class];

    //Initialize Parse in AppDelegate to point to our own server:
    ParseClientConfiguration *config = [ParseClientConfiguration   configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {

        configuration.applicationId = @"tasku";
        configuration.server = @"http://task-u.herokuapp.com/parse";

    }];

    [Parse initializeWithConfiguration:config];

    IQKeyboardManager.sharedManager.enable = true;

  #pragma mark - Persistent user login
     if (PFUser.currentUser) {
     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

     //self.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"AuthenticatedViewController"];
         self.animator = [[PanTabAnimator alloc] init];
    MainTabViewController *vc = (MainTabViewController*) [storyboard instantiateViewControllerWithIdentifier:@"AuthenticatedViewController"];
    //vc.delegate = self;
         self.window.rootViewController = vc;
    
     }

    return YES;

}

- (id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
            animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                              toViewController:(UIViewController *)toVC {
    
    NSUInteger fromVCIndex = [tabBarController.viewControllers indexOfObject:fromVC];
    NSUInteger toVCIndex = [tabBarController.viewControllers indexOfObject:toVC];
    
    self.animator.reverse = fromVCIndex < toVCIndex;
    return self.animator;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
