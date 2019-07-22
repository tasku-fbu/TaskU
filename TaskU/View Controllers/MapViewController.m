//
//  MapViewController.m
//  TaskU
//
//  Created by rhaypapenfuzz on 7/21/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "LocationsViewController.h"

@interface MapViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //one degree of latitude is approximately 111 kilometers (69 miles) at all times.
    MKCoordinateRegion howardU = MKCoordinateRegionMake(CLLocationCoordinate2DMake(38.922777, -77.019445), MKCoordinateSpanMake(0.05, 0.05)); //Have set default map to Howard University
    [self.mapView setRegion:howardU animated:false];
}

/*
 #pragma mark - Navigation
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Passes the selected object to the new view controller.
    
    UINavigationController *navigationController = [segue destinationViewController];
    LocationsViewController *LocationController = (LocationsViewController*)navigationController.topViewController;
    LocationController.delegate = self; //Setting the delegate in the prepareForSegue method
}

/*
 - (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
 <#code#>
 }
 - (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 <#code#>
 }
 - (void)locationsViewController:(nonnull LocationsViewController *)controller didPickLocationWithLatitude:(nonnull NSNumber *)latitude longitude:(nonnull NSNumber *)longitude {
 <#code#>
 }
 */
@end
