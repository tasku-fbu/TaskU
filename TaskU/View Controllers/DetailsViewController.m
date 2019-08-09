//
//  DetailsViewController.m
//  TaskU
//
//  Created by lucyyyw on 7/17/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "DetailsViewController.h"
#import "PanTabAnimator.h"
#import "VCTransitionsLibrary/CEHorizontalSwipeInteractionController.h"


@interface DetailsViewController () <UITabBarControllerDelegate>


@end

@implementation DetailsViewController
/*{
    PanTabAnimator *_animationController;
    CEHorizontalSwipeInteractionController *_swipeInteractionController;
}
 */
/*
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.delegate = self;
        _animationController = [PanTabAnimator new];
        _swipeInteractionController = [CEHorizontalSwipeInteractionController new];
        [self addObserver:self
               forKeyPath:@"selectedViewController"
                  options:NSKeyValueObservingOptionNew
                  context:nil];
    
       
    }
    return self;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"selectedViewController"] )
    {
        // wire the interaction controller to the view controller
        [_swipeInteractionController wireToViewController:self.selectedViewController
                                             forOperation:CEInteractionOperationTab];
    }
}



- (id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
            animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                              toViewController:(UIViewController *)toVC {
    
    NSUInteger fromVCIndex = [tabBarController.viewControllers indexOfObject:fromVC];
    NSUInteger toVCIndex = [tabBarController.viewControllers indexOfObject:toVC];
    
    _animationController.reverse = fromVCIndex < toVCIndex;
    return _animationController;
}

-(id<UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return _swipeInteractionController.interactionInProgress ? _swipeInteractionController : nil;
}
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self.tabBar setSelectedItem:[[self.tabBar items] objectAtIndex:1]];
    
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
