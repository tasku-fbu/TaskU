//
//  CompletedRequestsViewController.m
//  TaskU
//
//  Created by lucyyyw on 7/22/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "CompletedRequestsViewController.h"
#import "TaskCell.h"
#import "DetailsInfoViewController.h"
#import "DetailsViewController.h"
#import "DetailsStatusViewController.h"
#import "PanNormalAnimator.h"
#import "VCTransitionsLibrary/CEBaseInteractionController.h"
#import "PanTabAnimator.h"
#import "CustomRefreshControl.h"

@interface CompletedRequestsViewController () <UIViewControllerTransitioningDelegate,UITabBarControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *completedTable;
@property (strong,nonatomic) CustomRefreshControl *activityIndicator;
@property (strong, nonatomic) NSMutableArray *completedTasks;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic, strong) PanNormalAnimator *animationController;
@property (strong, nonatomic) PanTabAnimator * tabAnimator;
@end

@implementation CompletedRequestsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.animationController = [[PanNormalAnimator alloc] init];
    self.tabAnimator = [[PanTabAnimator alloc] init];
    
    // Do any additional setup after loading the view.
    self.completedTable.delegate = self;
    self.completedTable.dataSource = self;
    
    [self getCompletedTasks];
    
    self.completedTable.rowHeight = UITableViewAutomaticDimension;
    //self.completedTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.completedTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.completedTable.tableFooterView.hidden = true;
    //self.completedTable.backgroundColor = [UIColor colorWithRed:240/255.0 green:248/255.0 blue:255 alpha:1];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(getCompletedTasks) forControlEvents:UIControlEventValueChanged];
    [self.completedTable insertSubview:self.refreshControl atIndex:0];
    
    CGRect frame = CGRectMake(10, 10, 100, 100);
    self.activityIndicator = [[CustomRefreshControl alloc] initWithFrame:frame];
    
    self.activityIndicator.tag = 101;  //tag: int used to identify view objects in your application.
    [self.view addSubview:self.activityIndicator];
    
    self.activityIndicator.center = self.view.center;
    
    [self performSelector:@selector(animateProgress) withObject:nil afterDelay:0.5];
    

    
}

-(void)animateProgress{
    CustomRefreshControl *refresh = [self.view viewWithTag:101];
    [refresh setProgressWithAnimation:0.5 withValue:1];
}

- (void) endAnimation {
    [self.activityIndicator removeFromSuperview];
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

- (void) getCompletedTasks{
    PFUser *user = [PFUser currentUser];
    
    
    PFQuery *query1 = [PFQuery queryWithClassName:@"Task"];
    NSArray *completed = [NSArray arrayWithObjects: @"completed",@"pay",@"paid",@"expired", nil];
    [query1 whereKey:@"completionStatus" containedIn:completed];
    
    PFQuery *query2 = [PFQuery queryWithClassName:@"Task"];
    [query2 whereKey:@"completionStatus" equalTo:@"created"];
    NSDate *now = [NSDate date];
    [query2 whereKey:@"taskDate" lessThanOrEqualTo:now];
    
    PFQuery *query = [PFQuery orQueryWithSubqueries:@[query1,query2]];
    
    
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
    [query includeKey:@"email"];
    
    [query whereKey:@"requester" equalTo:user];
    
    
    
    //query.limit = 0;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *tasks, NSError *error) {
        if (tasks != nil) {
            // do something with the array of object returned by the call
            self.completedTasks = [tasks mutableCopy];
            
            [self.completedTable reloadData];
            [self.refreshControl endRefreshing];
            [self performSelector:@selector(endAnimation) withObject:nil afterDelay:0.5];
        } else {
            NSLog(@"%@", error.localizedDescription);
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Cannot fetch request history"
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
    
    TaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCell"];
    
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"RequestCellView" bundle:nil] forCellReuseIdentifier:@"RequestCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"RequestCell"];
    }
    cell.delegate = self;
    Task *task = self.completedTasks[indexPath.row];
    
    [cell showRequestCell:cell withRequest:task];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.completedTasks.count;
}

- (NSString *) stringfromDateHelper: (NSDate *) date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm, MM.d, YYYY"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

- (void)didTapDetails:(TaskCell *) cell {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Details" bundle:nil];
    UINavigationController *navigationVC = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"Details"];
    
    DetailsViewController *detailsVC = (DetailsViewController *) navigationVC.topViewController;
    detailsVC.task = cell.task;
    
    
    DetailsStatusViewController *statusVC = (DetailsStatusViewController *) detailsVC.viewControllers[0];
    DetailsInfoViewController *infoVC = (DetailsInfoViewController *) detailsVC.viewControllers[1];
    statusVC.task = cell.task;
    infoVC.task = cell.task;
    navigationVC.modalTransitionStyle = UIModalPresentationCustom;
    navigationVC.transitioningDelegate = self;
    detailsVC.delegate = self;
    [self presentViewController:navigationVC animated:YES completion:nil];
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Details" bundle:nil];
    UINavigationController *navigationVC = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"Details"];
    
    DetailsViewController *detailsVC = (DetailsViewController *) navigationVC.topViewController;
    Task *task = self.completedTasks[indexPath.row];
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
