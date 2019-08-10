//
//  CurrentMissionsViewController.m
//  TaskU
//
//  Created by lucyyyw on 7/22/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "CurrentMissionsViewController.h"
#import "TaskCell.h"
#import "DetailsStatusViewController.h"
#import "DetailsViewController.h"
#import "DetailsInfoViewController.h"
#import "PanNormalAnimator.h"
#import "VCTransitionsLibrary/CEBaseInteractionController.h"
#import "PanTabAnimator.h"
#import "CustomRefreshControl.h"

@interface CurrentMissionsViewController () <UIViewControllerTransitioningDelegate,UITabBarControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *currentTable;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) NSMutableArray *currentTasks;
@property (nonatomic, strong) PanNormalAnimator *animationController;
@property (strong, nonatomic) PanTabAnimator * tabAnimator;

@end

@implementation CurrentMissionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.animationController = [[PanNormalAnimator alloc] init];
    self.tabAnimator = [[PanTabAnimator alloc] init];
    // Do any additional setup after loading the view.
    self.currentTable.delegate = self;
    self.currentTable.dataSource = self;
    
    [self getCurrentTasks];
    
    self.currentTable.rowHeight = UITableViewAutomaticDimension;
    //self.currentTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.currentTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.currentTable.tableFooterView.hidden = true;
    //self.currentTable.backgroundColor = [UIColor colorWithRed:240/255.0 green:248/255.0 blue:255 alpha:1];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(getCurrentTasks) forControlEvents:UIControlEventValueChanged];
    [self.currentTable insertSubview:self.refreshControl atIndex:0];
    
    [self.activityIndicator startAnimating];
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.animationController.reverse = YES;
    return self.animationController;
}

- (id<UIViewControllerAnimatedTransitioning>) animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    self.animationController.reverse = NO;
    return self.animationController;
}
- (id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
            animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                              toViewController:(UIViewController *)toVC {
    
    NSUInteger fromVCIndex = [tabBarController.viewControllers indexOfObject:fromVC];
    NSUInteger toVCIndex = [tabBarController.viewControllers indexOfObject:toVC];
    
    self.tabAnimator.reverse = fromVCIndex < toVCIndex;
    return self.tabAnimator;
}

- (void) getCurrentTasks{
    PFUser *user = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"Task"];
    
    NSArray *current = [NSArray arrayWithObjects: @"created",@"accepted", nil];
    
    [query orderByAscending:@"taskDate"];
    [query includeKey:@"requester"];
    [query includeKey:@"taskDate"];
    [query includeKey:@"taskName"];
    [query includeKey:@"taskDifficulty"];
    [query includeKey:@"completionStatus"];
    [query includeKey:@"missioner"];
    [query includeKey:@"startAddress"];
    [query includeKey:@"endAddress"];
    [query includeKey:@"taskImage"];
    [query includeKey:@"taskDescription"];
    [query includeKey:@"category"];
    [query includeKey:@"hours"];
    [query includeKey:@"minutes"];
    
    [query whereKey:@"missioner" equalTo:user];
    [query whereKey:@"completionStatus" containedIn:current];
    NSDate *now = [NSDate date];
    [query whereKey:@"taskDate" greaterThanOrEqualTo:now];
    
    
    //query.limit = 20;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *tasks, NSError *error) {
        if (tasks != nil) {
            // do something with the array of object returned by the call
            self.currentTasks = [tasks mutableCopy];
            
            [self.currentTable reloadData];
            [self.refreshControl endRefreshing];
            [self.activityIndicator stopAnimating];
        } else {
            NSLog(@"%@", error.localizedDescription);
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Cannot fetch current missions"
                                                                           message:@"Please check your network connection."
                                                                    preferredStyle:(UIAlertControllerStyleAlert)];
            
            // create an OK action
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 // handle response here.
                                                             }];
            // add the OK action to the alert controller
            [alert addAction:okAction];
            
            [self presentViewController:alert animated:YES completion:^{
                // optional code for what happens after the alert controller has finished presenting
            }];
        }
        
    }];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    TaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MissionCell"];
    
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"MissionCellView" bundle:nil] forCellReuseIdentifier:@"MissionCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"MissionCell"];
    }
    cell.delegate = self;
    Task *task = self.currentTasks[indexPath.row];
    
    [cell showMissionCell:cell withMission:task];
    
    return cell;
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.currentTasks.count;
}

- (NSString *) stringfromDateHelper: (NSDate *) date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm, MM.d, YYYY"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}


- (void) didTapDetails:(TaskCell *) cell {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Details" bundle:nil];
    UINavigationController *navigationVC = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"Details"];
    
    DetailsViewController *detailsVC = (DetailsViewController *) navigationVC.topViewController;
    detailsVC.task = cell.task;
    
    
    DetailsStatusViewController *statusVC = (DetailsStatusViewController *) detailsVC.viewControllers[0];
    DetailsInfoViewController *infoVC = (DetailsInfoViewController *) detailsVC.viewControllers[1];
    statusVC.task = cell.task;
    statusVC.missionDelegate = self;
    infoVC.task = cell.task;
    navigationVC.modalTransitionStyle = UIModalPresentationCustom;
    navigationVC.transitioningDelegate = self;
    detailsVC.delegate = self;
    [self presentViewController:navigationVC animated:YES completion:nil];
    
}

- (void) didCancelMission {
    [self getCurrentTasks];
    [self.currentTable reloadData];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Details" bundle:nil];
    UINavigationController *navigationVC = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"Details"];
    
    DetailsViewController *detailsVC = (DetailsViewController *) navigationVC.topViewController;
    Task *task = self.currentTasks[indexPath.row];
    detailsVC.task = task;
    DetailsStatusViewController *statusVC = (DetailsStatusViewController *) detailsVC.viewControllers[0];
    DetailsInfoViewController *infoVC = (DetailsInfoViewController *) detailsVC.viewControllers[1];
    statusVC.task = task;
    infoVC.task = task;
    navigationVC.modalTransitionStyle = UIModalPresentationCustom;
    navigationVC.transitioningDelegate = self;
    detailsVC.delegate = self;
    [self presentViewController:navigationVC animated:YES completion:nil];
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
