//
//  CompletedMissionsViewController.m
//  TaskU
//
//  Created by lucyyyw on 7/22/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "CompletedMissionsViewController.h"
#import "TaskCell.h"
#import "DetailsInfoViewController.h"
#import "DetailsViewController.h"
#import "DetailsStatusViewController.h"

@interface CompletedMissionsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *completedTable;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) NSMutableArray *completedTasks;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@end

@implementation CompletedMissionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.completedTable.delegate = self;
    self.completedTable.dataSource = self;
    
    [self getCompletedTasks];
    self.completedTable.rowHeight = UITableViewAutomaticDimension;
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(getCompletedTasks) forControlEvents:UIControlEventValueChanged];
    [self.completedTable insertSubview:self.refreshControl atIndex:0];
    
    [self.activityIndicator startAnimating];
    
}

- (void) getCompletedTasks{
    PFUser *user = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"Task"];
    
    NSArray *completed = [NSArray arrayWithObjects: @"completed",@"pay",@"paid", nil];
    
    [query orderByDescending:@"taskDate"];
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
    [query whereKey:@"completionStatus" containedIn:completed];
    
    //query.limit = 0;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *tasks, NSError *error) {
        if (tasks != nil) {
            // do something with the array of object returned by the call
            self.completedTasks = [tasks mutableCopy];
            
            [self.completedTable reloadData];
            [self.refreshControl endRefreshing];
            [self.activityIndicator stopAnimating];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        
    }];
    
    
    
    
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    TaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCell"];
    
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"TaskCellView" bundle:nil] forCellReuseIdentifier:@"TaskCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCell"];
    }
    cell.delegate = self;
    Task *task = self.completedTasks[indexPath.row];
    
    [cell showCell:cell withTask:task];
    
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
