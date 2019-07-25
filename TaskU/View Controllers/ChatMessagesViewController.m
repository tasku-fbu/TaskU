//
//  ChatMessagesViewController.m
//  TaskU
//
//  Created by lucyyyw on 7/23/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "ChatMessagesViewController.h"
#import "Message.h"
#import "MyMessageCell.h"
#import "YourMessageCell.h"
#import "UIImageView+AFNetworking.h"

@interface ChatMessagesViewController ()
@property (weak, nonatomic) IBOutlet UITableView *messageTable;
@property (weak, nonatomic) IBOutlet UITextView *sendTextView;
@property (strong, nonatomic) NSMutableArray *messages;
@property (weak, nonatomic) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UILabel *contactLabel;


@property (nonatomic, assign) BOOL shouldScrollToLastRow;
@property (nonatomic, assign) int numData;

@end

@implementation ChatMessagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.messageTable.frame.size.width, 50)];
    [self.messageTable setTableFooterView:view];
    
    self.shouldScrollToLastRow = YES;
    self.contactLabel.text = self.contact.username;
    
    self.messageTable.delegate = self;
    self.messageTable.dataSource = self;
    self.messageTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.messageTable.rowHeight = UITableViewAutomaticDimension;
    self.sendTextView.layer.borderWidth = 2.0f;
    self.sendTextView.layer.borderColor = [[UIColor grayColor] CGColor];
    [self getMessages];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(getMessages) userInfo:nil repeats:true];
    
}

- (void) getMessages{
    //NSLog(@"%@",self.contact);
    PFUser *me = [PFUser currentUser];
    PFUser *you = self.contact;
    
    if (you) {
        PFQuery *query1 = [PFQuery queryWithClassName:@"Message"];
        
        [query1 whereKey:@"sender" equalTo:me];
        [query1 whereKey:@"receiver" equalTo:you];
        
        PFQuery *query2 = [PFQuery queryWithClassName:@"Message"];
        
        [query2 whereKey:@"sender" equalTo:you];
        [query2 whereKey:@"receiver" equalTo:me];
        
        PFQuery *mainQuery = [PFQuery orQueryWithSubqueries:@[query1,query2]];
        [mainQuery orderByAscending:@"createdAt"];
        [mainQuery includeKey:@"text"];
        [mainQuery includeKey:@"sender"];
        [mainQuery includeKey:@"createdAt"];
        [mainQuery includeKey:@"receiver"];
        
        // fetch data asynchronously
        [mainQuery findObjectsInBackgroundWithBlock:^(NSArray *messages, NSError *error) {
            if (messages != nil) {
                // do something with the array of object returned by the call
                self.messages = [messages mutableCopy];
                //NSLog(@"%@",self.messages);
                [self.messageTable reloadData];
                int temp = (int) messages.count;
                if (temp > self.numData) {
                    self.numData = temp;
                    self.shouldScrollToLastRow = YES;
                }
                
                
            } else {
                NSLog(@"%@", error.localizedDescription);
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Network Error"
                                                                               message:@"Please check your network connection."
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];
                
                // create an OK action
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                                   style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction * _Nonnull action) {
                                                                     // handle response here.
                                                                 }];
                // add the OK action to the alert controller
                [alert addAction:okAction];
                
                [self presentViewController:alert animated:YES completion:^{
                    // optional code for what happens after the alert controller has finished presenting
                }];
            }
            
        }];
    }
    
    
}
    







- (IBAction)onClickSend:(id)sender {
    self.shouldScrollToLastRow = YES;
    NSString *text = self.sendTextView.text;
    [Message sendMessage:text toReceiver:self.contact withCompletion:^(BOOL succeeded, NSError *_Nullable error) {
        if (error != nil) {
            NSLog(@"User send message failed: %@", error.localizedDescription);
            
        } else {
            NSLog(@"User sent message successfully");
            [self getMessages];
            [self.messageTable reloadData];
        }
    }];
    self.sendTextView.text = @"";
    
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    Message *message = self.messages[indexPath.row];
    PFUser *me = [PFUser currentUser];
    PFUser *you = self.contact;
    if ([message.sender.objectId isEqualToString:me.objectId]) {
        MyMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myMessage"];
        
        PFFileObject *imageFile = me[@"profileImage"];
        NSString *urlString = imageFile.url;
        [cell.myImageView setImageWithURL:[NSURL URLWithString:urlString]];
        
        cell.myTextLabel.text = message.text;
        cell.bubbleView.layer.cornerRadius = 12;
        cell.bubbleView.clipsToBounds = true;
        
        return cell;
    } else {
        YourMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yourMessage"];
        PFFileObject *imageFile = you[@"profileImage"];
        NSString *urlString = imageFile.url;
        [cell.yourImageView setImageWithURL:[NSURL URLWithString:urlString]];
        
        cell.yourTextLabel.text = message.text;
        cell.bubbleView.layer.cornerRadius = 12;
        cell.bubbleView.clipsToBounds = true;
        
        return cell;
    }
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}





- (IBAction)onClickBack:(id)sender {
    [self.timer invalidate];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) viewDidDisappear:(BOOL)animated {
    [self.timer invalidate];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    // Scroll table view to the last row
    if (self.shouldScrollToLastRow)
    {
        self.shouldScrollToLastRow = NO;
        [self.messageTable setContentOffset:CGPointMake(0, CGFLOAT_MAX)];
        //CGPoint bottomOffset = CGPointMake(0, self.messageTable.contentSize.height);
        //[self.messageTable setContentOffset:bottomOffset animated:NO];
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
