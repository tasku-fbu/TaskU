//
//  RequestsViewController.m
//  TaskU
//
//  Created by rhaypapenfuzz on 7/15/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "RequestsViewController.h"

@interface RequestsViewController ()
@property (weak, nonatomic) IBOutlet UIView *completedView;
@property (weak, nonatomic) IBOutlet UIView *currentView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentctrl;

@end

@implementation RequestsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UINavigationBar *bar = [self.navigationController navigationBar];
    [bar setBarTintColor:[UIColor colorWithRed:56/255.0 green:151.0/255 blue:240/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setTranslucent:NO];
    //self.view.backgroundColor = [UIColor colorWithRed:56/255.0 green:151.0/255 blue:240/255.0 alpha:1.0];
    //[self.navigationController.navigationBar addSubview:self.segmentctrl];
}
- (IBAction)showContainerView:(id)sender {
    if (self.segmentctrl.selectedSegmentIndex == 0) {
        self.completedView.alpha = 0;
        self.currentView.alpha = 1;
    } else {
        self.completedView.alpha = 1;
        self.currentView.alpha = 0;
    }
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
