//
//  AllChatsViewController.m
//  TaskU
//
//  Created by lucyyyw on 7/23/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import <Parse/Parse.h>
#import "AllChatsViewController.h"
#import "Message.h"


@interface AllChatsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

//@property (strong, nonatomic) NSMutableArray *contacts;
//@property (strong, nonatomic) NSMutableArray *allMessages;
//@property (strong, nonatomic) NSMutableArray *messagesByContact;

@property (strong, nonatomic) NSDictionary *messagesByContact;
@end

@implementation AllChatsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void) getAllMessages {
    PFQuery *query1 = [PFQuery queryWithClassName:@"Message"];
    [query1 includeKey:@"sender"];
    [query1 includeKey:@"createdAt"];
    [query1 includeKey:@"receiver"];
    [query1 whereKey:@"sender" equalTo:[PFUser currentUser]];
    
    PFQuery *query2 = [PFQuery queryWithClassName:@"Message"];
    [query2 includeKey:@"sender"];
    [query2 includeKey:@"createdAt"];
    [query2 includeKey:@"receiver"];
    [query2 whereKey:@"receiver" equalTo:[PFUser currentUser]];
    
    PFQuery *mainQuery = [PFQuery orQueryWithSubqueries:@[query1,query2]];
    [mainQuery orderByAscending:@"createdAt"];
    [mainQuery findObjectsInBackgroundWithBlock:^(NSArray *messages, NSError *error) {
        if (messages != nil) {
            // do something with the array of object returned by the call
           // self.contacts = [NSMutableArray new];
            //self.messagesByContact = [NSMutableArray new];
            self.messagesByContact = [NSDictionary new];
            
            [self processMessages: messages];
            
            [self.tableView reloadData];
            //[self.refreshControl endRefreshing];
            //[self.activityIndicator stopAnimating];
            
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        
    }];
}

- (void) processMessages:(NSArray *) messages{
    for (Message *message in messages) {
        PFUser *sender = message[@"sender"];
        PFUser *receiver = message[@"receiver"];
        PFUser *contact;
        if ( [sender isEqual:[PFUser currentUser]]) {
            contact = receiver;
        } else {
            contact = sender;
        }
       // if (self.messagesByContact valueForKey:@")
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
