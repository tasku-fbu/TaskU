//
//  HomeToTimelineViewController.m
//  TaskU
//
//  Created by lucyyyw on 8/4/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "HomeToTimelineViewController.h"
#import "Timeline1ViewController.h"

@interface HomeToTimelineViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation HomeToTimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    /*
    UINavigationController *navigationVC = (UINavigationController *)[segue destinationViewController];
    Timeline1ViewController *timelineVC = (Timeline1ViewController*)navigationVC.topViewController;
     */
    Timeline1ViewController *timelineVC = (Timeline1ViewController*) [segue destinationViewController];
    timelineVC.category = self.chosenCategory;
}


@end
