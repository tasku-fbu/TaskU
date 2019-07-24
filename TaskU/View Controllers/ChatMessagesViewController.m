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

@end

@implementation ChatMessagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getMessages];
}

- (void) getMessages{
    
    
}






- (IBAction)onClickSend:(id)sender {
    NSString *text = self.sendTextView.text;
    [Message sendMessage:text toReceiver:self.receiver withCompletion:^(BOOL succeeded, NSError *_Nullable error) {
        if (error != nil) {
            NSLog(@"User send message failed: %@", error.localizedDescription);
            
        } else {
            NSLog(@"User sent message successfully");
            [self getMessages];
            [self.messageTable reloadData];
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    Message *message = self.messages[indexPath.row];
    PFUser *me = [PFUser currentUser];
    PFUser *you = self.receiver;
    if ([message.sender isEqual:me]) {
        MyMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myMessage"];
        
        PFFileObject *imageFile = me[@"profileImage"];
        NSString *urlString = imageFile.url;
        [cell.myImageView setImageWithURL:[NSURL URLWithString:urlString]];
        
        cell.myTextLabel.text = message.text;
        
        return cell;
    } else {
        YourMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yourMessage"];
        PFFileObject *imageFile = you[@"profileImage"];
        NSString *urlString = imageFile.url;
        [cell.yourImageView setImageWithURL:[NSURL URLWithString:urlString]];
        
        cell.yourTextLabel.text = message.text;
        
        return cell;
    }
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}


@end
