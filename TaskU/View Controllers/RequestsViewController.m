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
@property (weak, nonatomic) IBOutlet UIView *helperView;
@property (weak, nonatomic) IBOutlet UIView *segmentView;

@end

@implementation RequestsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UINavigationBar *bar = [self.navigationController navigationBar];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width * 0.4;
    [self.segmentctrl setWidth:width forSegmentAtIndex:0];
    [self.segmentctrl setWidth:width forSegmentAtIndex:1];
    self.segmentctrl.layer.borderColor = [UIColor whiteColor].CGColor;
    self.segmentctrl.layer.borderWidth = 2.0f;
    self.segmentctrl.layer.cornerRadius = 8;
    self.segmentctrl.clipsToBounds = true;
    self.segmentView.layer.cornerRadius = 8;
    self.segmentView.clipsToBounds = true;
    
    
    [bar setBarTintColor:[UIColor colorWithRed:56/255.0 green:151.0/255 blue:240/255.0 alpha:1.0]];
    bar.translucent = false;
    bar.backgroundColor = [UIColor colorWithRed:56/255.0 green:151.0/255 blue:240/255.0 alpha:1.0];
    [bar setValue:@(YES) forKeyPath:@"hidesShadow"];
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName:[UIFont fontWithName:@"Quicksand-Bold" size:20]}];
    
    self.helperView.backgroundColor = [UIColor colorWithRed:56/255.0 green:151.0/255 blue:240/255.0 alpha:1.0];
    
    UISwipeGestureRecognizer *completedSwipeRecognizer = [[[UISwipeGestureRecognizer alloc] init] initWithTarget:self action:@selector(slideToLeftWithGestureRecognizer:)];
    completedSwipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.completedView addGestureRecognizer:completedSwipeRecognizer];
    
    UISwipeGestureRecognizer *currentSwipeRecognizer = [[[UISwipeGestureRecognizer alloc] init] initWithTarget:self action:@selector(slideToRightWithGestureRecognizer:)];
    currentSwipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.currentView addGestureRecognizer:currentSwipeRecognizer];
}

- (void) slideToLeftWithGestureRecognizer:(UISwipeGestureRecognizer *) gestureRecognizer {
    [UIView animateWithDuration:1.5 animations:^{
        self.segmentctrl.selectedSegmentIndex = 0;
        self.completedView.alpha = 0;
        self.currentView.alpha = 1;
    }];
}

- (void) slideToRightWithGestureRecognizer:(UISwipeGestureRecognizer *) gestureRecognizer {
    [UIView animateWithDuration:1.5 animations:^{
        self.segmentctrl.selectedSegmentIndex = 1;
        self.completedView.alpha = 1;
        self.currentView.alpha = 0;
    }];
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
