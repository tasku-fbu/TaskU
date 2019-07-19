//
//  Timeline1ViewController.m
//  TaskU
//
//  Created by lucyyyw on 7/16/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "Timeline1ViewController.h"
#import "TaskCell.h"
#import "Task.h"
#import "DetailsViewController.h"
#import "DetailsStatusViewController.h"
#import "DetailsInfoViewController.h"

@interface Timeline1ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *tasks;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation Timeline1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self getAllTasks];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(getAllTasks) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    [self.activityIndicator startAnimating];
    
}

//want to make it a public method in Task, so that it takes in a "category" and gets all tasks in this category
- (void) getAllTasks {
    PFQuery *query = [PFQuery queryWithClassName:@"Task"];
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
    
    //[query whereKey:@"completionStatus equalTo:@1"created"];
    query.limit = 20;
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *tasks, NSError *error) {
        if (tasks != nil) {
            // do something with the array of object returned by the call
            self.tasks = [tasks mutableCopy];
            
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
            [self.activityIndicator stopAnimating];
            
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        
    }];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCell"];
    cell.delegate = self;
    Task *task = self.tasks[indexPath.row];
    cell.task = task;
    cell.titleLabel.text = task[@"taskName"];
    
    
    PFUser *user = task[@"requester"];
    cell.requesterLabel.text = [NSString stringWithFormat:@"@%@", user.username];
    
    
    
    NSNumber *payment = task[@"pay"];
    int pay = [payment intValue];
    cell.paymentLabel.text = [NSString stringWithFormat:@"$%i",pay];
    
    NSString *startString = @"";
    if (task[@"startAddress"]) {
        if (![task[@"startAddress"] isEqualToString:@""]) {
            startString = [NSString stringWithFormat:@"FROM %@ ", task[@"startAddress"]];
        }
    }
    cell.destinationLabel.text = [NSString stringWithFormat:@"%@TO %@",
                                  startString,task[@"endAddress"]];
    
    
    NSDate *date = task[@"taskDate"];
    NSString *dateString = [self stringfromDateHelper:date];
    cell.dateLabel.text = [NSString stringWithFormat:@"due %@", dateString];
    
    
    NSNumber *hour = task[@"hours"];
    NSNumber *minute = task[@"minutes"];
    int hr = [hour intValue];
    int min = [minute intValue];
    if (hr == 0) {
        cell.timeLabel.text = [NSString stringWithFormat:@"%imin", min];
    } else if (min == 0){
        cell.timeLabel.text = [NSString stringWithFormat:@"%ihr", hr];
    } else {
        cell.timeLabel.text = [NSString stringWithFormat:@"%ihr %imin", hr,min];
    }
    
    
    
    
    return cell;
}


- (NSString *) stringfromDateHelper: (NSDate *) date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm, MM.d, YYYY"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}



- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tasks.count;
}


- (void) didTapDetails:(TaskCell *) cell {
    
     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Details" bundle:nil];
    UINavigationController *navigationVC = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"Details"];
    
    DetailsViewController *detailsVC = (DetailsViewController *) navigationVC.topViewController;
     detailsVC.task = cell.task;
     
    
    DetailsStatusViewController *statusVC = (DetailsStatusViewController *) detailsVC.viewControllers[0];
    DetailsInfoViewController *infoVC = (DetailsInfoViewController *) detailsVC.viewControllers[1];
    statusVC.task = cell.task;
    infoVC.task = cell.task;
    statusVC.delegate = self;
     [self presentViewController:navigationVC animated:YES completion:nil];
    
}

- (IBAction)onBackHome:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) didCancelRequest {
    [self getAllTasks];
    [self.tableView reloadData];
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
