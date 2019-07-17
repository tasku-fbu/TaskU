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
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(getAllTasks) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    [self.activityIndicator startAnimating];
    
}

//want to make it a public method in Task, so that it takes in a "category" and gets all tasks in this category
- (void) getAllTasks {
    PFQuery *query = [PFQuery queryWithClassName:@"Task"];
    [query orderByDescending:@"taskDate"];
    [query includeKey:@"reqester"];
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
    Task *task = self.tasks[indexPath.row];
    cell.task = task;
    cell.titleLabel.text = task[@"taskTitle"];
    cell.requesterLabel.text = @"testing";
    cell.paymentLabel.text = @"not on Parse";
    cell.dateLabel.text = task[@"taskDate"];
    
    return cell;
}



- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tasks.count;
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
