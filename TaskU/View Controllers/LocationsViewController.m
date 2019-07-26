//
//  LocationsViewController.m
//  TaskU
//
//  Created by rhaypapenfuzz on 7/21/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "LocationsViewController.h"
#import "LocationCell.h"
#import "Parse/Parse.h"


#pragma mark - interface and properties
@interface LocationsViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSArray *results;
@end

static NSString * const clientID = @"44AMDU33GRCGT1ZOPZAQDAG422E3AB4W51SNGHVF4WHEHUYG";
static NSString * const clientSecret = @"QUZTBM11UBAHE1KQVBISIF4CB1OWALMODUWMUCMFSKWNMXVQ";

@implementation LocationsViewController

#pragma mark - Location Search initial View Controller
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.searchBar.delegate = self;
    self.tableView.rowHeight = 55;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - tableView  datasource and delegate functions implementation
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LocationCell" forIndexPath:indexPath];
    [cell updateWithLocation:self.results[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // This is the selected venue
    NSDictionary *venue = self.results[indexPath.row];
    NSNumber *lat = [venue valueForKeyPath:@"location.lat"];
    NSNumber *lng = [venue valueForKeyPath:@"location.lng"];
    NSLog(@"%@, %@", lat, lng);
    
    //calling the locationsViewController delegate method with the latitude and longitude of the location the user selects.
    [self.delegate locationsViewController:self didPickLocationWithLatitude:(lat) longitude:(lng)];
    
}

#pragma mark - Query Set up (searches for possible locations using fourSqaure map API)
- (void)fetchLocationsWithQuery:(NSString *)query nearCity:(NSString *)city {
    city = @"San Francisco";
    NSString *baseURLString = @"https://api.foursquare.com/v2/venues/search?";
    NSString *queryString = [NSString stringWithFormat:@"client_id=%@&client_secret=%@&near=%@,CA&query=%@&v=20141020", clientID, clientSecret, city, query];
    queryString = [queryString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *url = [NSURL URLWithString:[baseURLString stringByAppendingString:queryString]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"response: %@", responseDictionary);
            self.results = [responseDictionary valueForKeyPath:@"response.venues"];
            [self.tableView reloadData];
        }
    }];
    [task resume];
}

- (IBAction)backButtonAction:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark -
//setting delegate in prepare for segue questioupd
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    PFUser *loggedInUser = [PFUser currentUser];
    NSString *schoolLocation = loggedInUser[@"university"]; //gets the university of current user
    
    NSString *newText = [searchBar.text stringByReplacingCharactersInRange:range withString:text];
    [self fetchLocationsWithQuery:newText nearCity:schoolLocation];
    return true;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    PFUser *loggedInUser = [PFUser currentUser];
    NSString *schoolLocation = loggedInUser[@"university"]; //gets the university of current user
    
    [self fetchLocationsWithQuery:searchBar.text nearCity:schoolLocation];
}

@end



