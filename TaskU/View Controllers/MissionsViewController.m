//
//  MissionsViewController.m
//  TaskU
//
//  Created by rhaypapenfuzz on 7/15/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "MissionsViewController.h"

@interface MissionsViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentctrl;
@property (weak, nonatomic) IBOutlet UIView *completedView;
@property (weak, nonatomic) IBOutlet UIView *currentView;

@end

@implementation MissionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
