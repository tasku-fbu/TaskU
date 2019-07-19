//
//  MainProfileViewController.m
//  TaskU
//
//  Created by panzaldo on 7/18/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "MainProfileViewController.h"
#import "Task.h"
#import <Parse/Parse.h>



@interface MainProfileViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation MainProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PFUser *user = [PFUser currentUser];
    self.nameLabel.text = user[@"name"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



@end
