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
#import "HomeViewController.h"
#import "LocationsViewController.h"
#import "UIImageView+AFNetworking.h"

#pragma mark - interface and properties
@interface Timeline1ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tasks;
@property (strong, nonatomic) NSArray *filteredData;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (strong, nonatomic) NSArray *results;
@property (strong, nonatomic) NSDictionary *venue;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@end

@implementation Timeline1ViewController

#pragma mark - Timeline initial View
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.searchBar.delegate = self;
    self.searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.searchBar.backgroundColor = [UIColor colorWithRed:240/255.0 green:248/255.0 blue:255 alpha:1];
    self.searchBar.barTintColor = [UIColor colorWithRed:240/255.0 green:248/255.0 blue:255 alpha:1];
    //self.searchBar.layer.borderColor = [UIColor colorWithRed:240/255.0 green:248/255.0 blue:255 alpha:1].CGColor;
    //self.searchBar.layer.borderWidth = 1;
    
    self.searchBar.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.searchBar.layer.shadowOffset = CGSizeMake(0,1.5f);
    self.searchBar.layer.shadowRadius = 2.0f;
    self.searchBar.layer.shadowOpacity = 0.5f;
    self.searchBar.layer.masksToBounds = NO;
    
    
    
    
    [self getAllTasks];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.tableFooterView.hidden = true;
    self.tableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:248/255.0 blue:255 alpha:1];
    
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

    [query whereKey:@"category" equalTo:(self.category)];
    [query whereKey:@"completionStatus" equalTo:@"created"];
    
    NSDate *now = [NSDate date];
    [query whereKey:@"taskDate" greaterThanOrEqualTo:now];
    
    query.limit = 20;
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *tasks, NSError *error) {
        if (tasks != nil) {
            // do something with the array of object returned by the call
            self.tasks = [tasks mutableCopy];
            self.filteredData = self.tasks;
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
    
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"TaskCellView" bundle:nil] forCellReuseIdentifier:@"TaskCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCell"];
    }
    cell.delegate = self;
    Task *task = self.filteredData[indexPath.row];
    
    [cell showCell:cell withTask:task];
    
    return cell;
}





- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredData.count;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if (searchText.length != 0) {
        
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(Task *task, NSDictionary *bindings) {
            NSString *name = task[@"taskName"];
            NSString *description = task[@"taskDescription"];
            return ([name.lowercaseString containsString:searchText.lowercaseString] || [description.lowercaseString containsString:searchText.lowercaseString]);
        }];
        self.filteredData = [self.tasks filteredArrayUsingPredicate:predicate];
        
        
        
        //NSLog(@"%@", self.filteredData);
        
    }
    else {
        self.filteredData = self.tasks;
    }
    
    [self.tableView reloadData];
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.searchBar.showsCancelButton = YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.searchBar.showsCancelButton = NO;
    self.searchBar.text = @"";
    [self.searchBar resignFirstResponder];
    self.filteredData = self.tasks;
    [self.tableView reloadData];
}


#pragma mark - navigates to details when task is selected, gets geo cordinates to display on the next view controller
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
    
    //get the coordinates of the selected task
   //[self fetchLocationsWithQuery:cell.task[@"startAddress"] nearCity:cell.task[@"startAddress"]];
    /*
    //NSDictionary *venue = self.results[indexPath.row];
    NSNumber *startLat = cell.task.startLatitude; //[@"startLatitude"]; //[self.venue valueForKeyPath:@"location.lat"];
    NSNumber *startLng = cell.task.startLongitude; //[@"startLongitude"]; //[self.venue valueForKeyPath:@"location.lng"];
    NSNumber *endLat = cell.task.endLatitude; //[@"endLatitude"];
    NSNumber *endLng = cell.task.endLongitude; //[@"endLongitude"];
    NSLog(@"startLat: %@, startLng: %@, endLat: %@ endLng: %@ ", startLat, startLng, endLat, endLng);
    
    // This is the starting coordinates
    statusVC.startLatitude = startLat;
    statusVC.startLongitude = startLng;
    statusVC.endLatitude = endLat;
    statusVC.endLongitude = endLng;
     */
    //calling the locationsViewController delegate method with the latitude and longitude of the location the user selects.
    //[self.delegate locationsViewController:self didPickLocationWithLatitude:(lat) longitude:(lng)];
    [self presentViewController:navigationVC animated:YES completion:nil];
    
}



#pragma mark - Query Set up (searches for task location using fourSqaure map API)
- (void)fetchLocationsWithQuery:(NSString *)query nearCity:(NSString *)city {
    city = @"San Francisco";
    static NSString * const clientID = @"44AMDU33GRCGT1ZOPZAQDAG422E3AB4W51SNGHVF4WHEHUYG";
    static NSString * const clientSecret = @"QUZTBM11UBAHE1KQVBISIF4CB1OWALMODUWMUCMFSKWNMXVQ";
    NSString *baseURLString = @"https://api.foursquare.com/v2/venues/search?";
    NSString *queryString = [NSString stringWithFormat:@"client_id=%@&client_secret=%@&v=20141020&near=%@,CA&query=%@", clientID, clientSecret, city, query];
    queryString = [queryString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *url = [NSURL URLWithString:[baseURLString stringByAppendingString:queryString]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"response: %@", responseDictionary);
            self.venue = [responseDictionary valueForKeyPath:@"response.venues"];
            [self.tableView reloadData];
        }
    }];
    [task resume];
}


- (IBAction)onBackHome:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) didCancelRequest {
    [self getAllTasks];
    [self.tableView reloadData];
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 



@end
