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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *sendHelperView;
@property (weak, nonatomic) IBOutlet UIView *sendTextHelperView;


@property (nonatomic, assign) BOOL shouldScrollToLastRow;
@property (nonatomic, assign) int numData;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation ChatMessagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.navigationController.navigationBar.topItem.title = self.contact.username;
    self.navigationItem.title = self.contact.username;
    UINavigationBar *bar = [self.navigationController navigationBar];
    [bar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [bar setShadowImage:[[UIImage alloc] init]];
    [bar setBarTintColor:[UIColor colorWithRed:56/255.0 green:151.0/255 blue:240/255.0 alpha:1.0]];
    bar.translucent = false;
    bar.backgroundColor = [UIColor colorWithRed:56/255.0 green:151.0/255 blue:240/255.0 alpha:1.0];
    [bar setValue:@(YES) forKeyPath:@"hidesShadow"];
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName:[UIFont fontWithName:@"Quicksand-Bold" size:20]}];
    
   
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.messageTable.frame.size.width, 20)];
    [self.messageTable setTableFooterView:view];
    
    self.sendTextView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    self.shouldScrollToLastRow = YES;
    
    
    //[self.sendTextView sizeToFit];
    self.sendTextView.scrollEnabled = false;
    //self.sendTextView.delegate = self;
    
    UIApplication.sharedApplication.keyWindow.backgroundColor = [UIColor whiteColor];
    
    
    self.messageTable.delegate = self;
    self.messageTable.dataSource = self;
    self.messageTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.messageTable.rowHeight = UITableViewAutomaticDimension;
    self.sendTextView.layer.borderWidth = 2.0f;
    self.sendTextView.layer.borderColor = [[UIColor grayColor] CGColor];
    [self getMessages];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(getMessages) forControlEvents:UIControlEventValueChanged];
    [self.messageTable insertSubview:self.refreshControl atIndex:0];
    [self.activityIndicator startAnimating];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(getMessages) userInfo:nil repeats:true];
    
}
/*
- (void)textViewDidChange:(UITextView *)textView
{
    NSUInteger maxNumberOfLines = 3;
    NSUInteger numLines = textView.contentSize.height/textView.font.lineHeight;
    if (numLines >= maxNumberOfLines)
    {
        
        CGRect frame = self.sendTextView.frame;
        frame.size.height = maxNumberOfLines * textView.font.lineHeight;
        self.sendTextView.frame = frame;
        self.sendTextView.scrollEnabled = true;
    } else if (numLines == maxNumberOfLines - 1){
        [self.sendTextView sizeToFit];
        self.sendTextView.scrollEnabled = false;
    }
}
*/

- (void) getMessages{
    //NSLog(@"%@",self.contact);
    
    
    PFUser *me = [PFUser currentUser];
    PFUser *you = self.contact;
    
    //if (you) {
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
                
                int temp = (int) messages.count;
                if (temp > self.numData) {
                    self.numData = temp;
                    
                    self.messages = [messages mutableCopy];
                    
                    //NSLog(@"%@",self.messages);
                    
                    [self.messageTable reloadData];
                    
                    [self scrollToBottom];
                    
                }
                
                [self.refreshControl endRefreshing];
                [self.activityIndicator stopAnimating];
                
                
                
                
            } else {
                NSLog(@"%@", error.localizedDescription);
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Network failure."
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
    //}
    
    
}
    




- (IBAction)onClickSend:(id)sender {
    self.shouldScrollToLastRow = YES;
    NSString *text = self.sendTextView.text;
    if (self.contact) {
        [Message sendMessage:text toReceiver:self.contact withCompletion:^(BOOL succeeded, NSError *_Nullable error) {
            if (error != nil) {
                NSLog(@"User send message failed: %@", error.localizedDescription);
                
            } else {
                NSLog(@"User sent message successfully");
                [self getMessages];
                
                //self.shouldScrollToLastRow = YES;
                [self.messageTable reloadData];
                self.sendTextView.text = @"";
            }
        }];
    } else {
        NSLog(@"Contact nil");
    }
    
    
    
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
        cell.myImageView.layer.cornerRadius = 17.5;
        cell.myImageView.clipsToBounds = YES;
        
        cell.myTextLabel.text = message.text;
        cell.bubbleView.layer.cornerRadius = 12;
        cell.bubbleView.clipsToBounds = true;
        
        return cell;
    } else {
        YourMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yourMessage"];
        PFFileObject *imageFile = you[@"profileImage"];
        NSString *urlString = imageFile.url;
        [cell.yourImageView setImageWithURL:[NSURL URLWithString:urlString]];
        cell.yourImageView.layer.cornerRadius = 17.5;
        cell.yourImageView.clipsToBounds = YES;
        
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

/*
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
*/
 
- (IBAction)onTapOutsideTextView:(id)sender {
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    /*
    [self.messageTable reloadData];
    NSIndexPath* ip = [NSIndexPath indexPathForRow:[self.messageTable numberOfRowsInSection:0] - 1 inSection:0];
    [self.messageTable scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:NO];
    */
    
    //[self.messageTable reloadData];
    //int lastRowNumber = (int *)[self.messageTable numberOfRowsInSection:0] - 1;
    
    
}

- (void) viewDidAppear:(BOOL)animated {
    [self scrollToBottom];
    
}

- (void) scrollToBottom {
    if (self.messages.count > 0) {
        NSIndexPath *ip = [NSIndexPath indexPathForRow:self.messages.count - 1 inSection:0];
        [self.messageTable scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
}

#pragma mark - keyboard movements
- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = -keyboardSize.height + self.view.safeAreaInsets.top + self.navigationController.navigationBar.frame.size.height + 16;
        self.view.frame = f;
        
    }];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = self.navigationController.navigationBar.frame.size.height + self.view.safeAreaInsets.top + 16;
        self.view.frame = f;
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

@end
