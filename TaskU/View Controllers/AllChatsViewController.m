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
#import "UIImageView+AFNetworking.h"
#import "ChatMessagesViewController.h"

@interface AllChatsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableDictionary *messagesByContact;
@property (weak, nonatomic) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation AllChatsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self getAllMessages];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(getAllMessages) userInfo:nil repeats:true];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(getAllMessages) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    [self.activityIndicator startAnimating];
    
}


- (void) getAllMessages {
    if (![PFUser currentUser]) {
        [self.timer invalidate];
    } else {
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
                self.messagesByContact = [NSMutableDictionary new];
                
                [self processMessages: messages];
                
                [self.tableView reloadData];
                [self.refreshControl endRefreshing];
                [self.activityIndicator stopAnimating];
                
            } else {
                NSLog(@"%@", error.localizedDescription);
            }
            
        }];
    }
}

- (void) processMessages:(NSArray *) messages{
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    for (Message *message in messages) {
        PFUser *sender = message[@"sender"];
        PFUser *receiver = message[@"receiver"];
        PFUser *contact;
        if ( [sender.objectId isEqual:[PFUser currentUser].objectId]) {
            contact = receiver;
            
        } else {
            contact = sender;
            
        }
        
        NSString *myKey = contact.objectId;
        [dictionary setObject:message forKey:myKey];
    }
    
    
    //sort the contacts by latest conversation
    NSArray* sortedKeys = [dictionary keysSortedByValueUsingComparator:^(id first, id second) {
        Message *latestMessage1 = (Message*) first;
        Message *latestMessage2 = (Message*) second;
        NSDate *date1 = latestMessage1[@"createdAt"];
        NSDate *date2 = latestMessage2[@"createdAt"];
        if ([date1 compare:date2] == NSOrderedAscending) {
            return (NSComparisonResult)NSOrderedDescending;
        } else {
            return (NSComparisonResult)NSOrderedAscending;
        }
    }];
    
    for (NSString *contact in sortedKeys) {
        NSArray *tempMessage = [dictionary objectForKey:contact];
        [self.messagesByContact setObject:tempMessage forKey:contact];
    }
    
    //NSLog(@"%@",self.messagesByContact);
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contactCell"];
    NSString *objectIdContact = self.messagesByContact.allKeys[indexPath.row];
    
    
    PFQuery * query = [PFUser query];
    [query whereKey:@"objectId" equalTo:objectIdContact];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *users, NSError *error) {
        if (users != nil) {
            
            PFUser *contact = [users firstObject];
            cell.contactUsernameLabel.text = contact[@"username"];
            PFFileObject *imageFile = contact[@"profileImage"];
            NSString *urlString = imageFile.url;
            [cell.contactProfileImageView setImageWithURL:[NSURL URLWithString:urlString]];
            cell.contact = contact;
            
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        
    }];
    
    
    Message *latest = [self.messagesByContact objectForKey:objectIdContact];
    cell.latestTextLabel.text = latest[@"text"];
    
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *keyArr = self.messagesByContact.allKeys;
    return keyArr.count;
}

/*
- (void) viewDidDisappear:(BOOL)animated {
    [self.timer invalidate];
}
*/
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"showMessages"]) {
        ContactCell *tappedCell = (ContactCell*)sender;
        ChatMessagesViewController *chatMessagesController = [segue destinationViewController];
        chatMessagesController.contact = tappedCell.contact;
        
        
    }
}






@end
