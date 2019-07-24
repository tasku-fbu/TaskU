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
#import "ContactCell.h"

@interface AllChatsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

//@property (strong, nonatomic) NSMutableArray *contacts;
//@property (strong, nonatomic) NSMutableArray *allMessages;
//@property (strong, nonatomic) NSMutableArray *messagesByContact;

@property (strong, nonatomic) NSMutableDictionary *messagesByContact;
@end

@implementation AllChatsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    [self getAllMessages];
}


- (void) getAllMessages {
    PFQuery *query1 = [PFQuery queryWithClassName:@"Message"];
    
    [query1 whereKey:@"sender" equalTo:[PFUser currentUser]];
    
    PFQuery *query2 = [PFQuery queryWithClassName:@"Message"];
    
    [query2 whereKey:@"receiver" equalTo:[PFUser currentUser]];
    
    PFQuery *mainQuery = [PFQuery orQueryWithSubqueries:@[query1,query2]];
    [mainQuery includeKey:@"createdAt"];
    [mainQuery includeKey:@"sender"];
    [mainQuery includeKey:@"receiver"];
    [mainQuery includeKey:@"text"];
    [mainQuery orderByAscending:@"createdAt"];
    [mainQuery findObjectsInBackgroundWithBlock:^(NSArray *messages, NSError *error) {
        if (messages != nil) {
            // do something with the array of object returned by the call
           // self.contacts = [NSMutableArray new];
            //self.messagesByContact = [NSMutableArray new];
            self.messagesByContact = [NSMutableDictionary new];
            
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
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    for (Message *message in messages) {
        PFUser *sender = message[@"sender"];
        PFUser *receiver = message[@"receiver"];
        PFUser *contact;
        if ( [sender isEqual:[PFUser currentUser]]) {
            contact = receiver;
        } else {
            contact = sender;
        }
        
        NSValue *myKey = [NSValue valueWithNonretainedObject:contact];
        
        if ([dictionary objectForKey:myKey]) {
            NSMutableArray *messagesForContact = [dictionary objectForKey:myKey];
            [messagesForContact addObject:message];
        } else {
            NSMutableArray *messagesForContact = [NSMutableArray arrayWithObjects:message, nil];
            [dictionary setObject:messagesForContact forKey:myKey];
        }
    }
    
    
    //sort the contacts by latest conversation
    NSArray* sortedKeys = [dictionary keysSortedByValueUsingComparator:^(id first, id second) {
        Message *latestMessage1 = [(NSMutableArray*)first lastObject];
        Message *latestMessage2 = [(NSMutableArray*)second lastObject];
        NSDate *date1 = latestMessage1[@"createdAt"];
        NSDate *date2 = latestMessage2[@"createdAt"];
        if ([date1 compare:date2] == NSOrderedAscending) {
            return (NSComparisonResult)NSOrderedDescending;
        } else {
            return (NSComparisonResult)NSOrderedAscending;
        }
    }];
    
    for (NSValue *contact in sortedKeys) {
        NSArray *tempMessages = [dictionary objectForKey:contact];
        [self.messagesByContact setObject:tempMessages forKey:contact];
    }
    
    //NSLog(@"%@",self.messagesByContact);
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contactCell"];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *keyArr = self.messagesByContact.allKeys;
    return keyArr.count;
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
