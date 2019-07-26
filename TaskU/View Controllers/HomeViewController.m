//
//  HomeViewController.m
//  TaskU
//
//  Created by rhaypapenfuzz on 7/15/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCollectionViewCell.h"
#import "Timeline1ViewController.h"
#import "newTaskViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "Parse/Parse.h"
//#import "ProfileSlideView.h"

#pragma mark - interface and properties
@interface HomeViewController () < UICollectionViewDelegate, UICollectionViewDataSource, HomeCollectionCellDelegate>
@property NSArray *categoriesImagesArray;
@property NSArray *categoriesTextArray;
@property (weak, nonatomic) IBOutlet UICollectionView *collection_View;
@property (weak, nonatomic) IBOutlet UIButton *LocationButton;

@property NSString *userLocation;

//@property(nonatomic, strong) ProfileSlideView *leftViewToSlideIn;
//@property (weak, nonatomic) IBOutlet UIButton *profileButton;

@end

@implementation HomeViewController

@synthesize collection_View;
static NSString * const reuseIdentifier = @"HomeCollectionViewCell_ID";
static NSString * const messageSegueIdentifier = @"messageSegue";

#pragma mark - Home initial view
- (void)viewDidLoad {
    [super viewDidLoad];
    PFUser *loggedInUser = [PFUser currentUser];
    // Do any additional setup after loading the view.
    
    self.userLocation = loggedInUser[@"university"]; //gets the university of current user
    [self.LocationButton setTitle:self.userLocation forState:UIControlStateNormal];
    
    self.categoriesImagesArray = [[NSArray alloc] initWithObjects:@"get_coffee",@"groceries", @"tutoring", @"Laundry", @"movingIn", @"specialServices",  nil ];
    self.categoriesTextArray = [[NSArray alloc] initWithObjects:@"Delivery",@"Groceries", @"Tutoring", @"Laundry & Cleaning", @"Volunteering",  @"Other", nil ];
    
    //[self.view addSubview:self.profileButton]; //slideMenu
    // [self createInitialSlideView];
    
}

#pragma mark - University location button action
-(IBAction)LocationButtonAction:(id)sender {
    PFUser *loggedInUser = [PFUser currentUser];
    self.userLocation = loggedInUser[@"university"]; //gets the university of current user
    [self.LocationButton setTitle:self.userLocation forState:UIControlStateSelected];
}

/*
 #pragma mark - collectionview cell datasource and delegate functions implementation
 - (IBAction)profileButtonAction:(id)sender {
 [self animateView];
 }
 - (void) createInitialSlideView{
 self.leftViewToSlideIn = [[ProfileSlideView alloc] initWithFrame:CGRectMake(0, 0, 0 , CGRectGetWidth(self.view.frame))];
 [self.leftViewToSlideIn loadView];
 self.leftViewToSlideIn.backgroundColor = [UIColor whiteColor];
 [self.view addSubview:self.leftViewToSlideIn];
 }
 
 - (void) buttonClicked: (id)sender
 {
 [self animateView];
 
 }
 
 - (void) animateView{
 [UIView animateWithDuration: 0.75 animations:^{
 self.leftViewToSlideIn.frame = CGRectMake(0,CGRectGetWidth(self.view.frame)-330, 280 , CGRectGetWidth(self.view.frame));
 }];
 }
 
 
 - (void) didTapOnPageView:(UITapGestureRecognizer *)sender{
 // TODO: Call method on delegate
 [self animateViewBackwards];
 
 }
 
 - (void) animateViewBackwards{
 [UIView animateWithDuration: 0.75 animations:^{
 //self.leftViewToSlideIn.frame = CGRectMake(CGRectGetWidth(self.view.frame), 0, 0 , 400);
 self.leftViewToSlideIn.frame = CGRectMake(4000, 0, 0, 400);
 }];
 }
 
 */

#pragma mark - collectionview cell datasource and delegate functions implementation
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.categoriesImagesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:(100)];
    
    //want to resize images later
    imageView.image = [UIImage imageNamed: [self.categoriesImagesArray objectAtIndex:indexPath.row]];
    
    UILabel *label = (UILabel *)[cell viewWithTag:(101)];
    label.text = [self.categoriesTextArray objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - helps us know which collection view cell category was tapped and then navigates
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Timeline1" bundle:nil];
    UINavigationController *navigationVC = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"Timeline1"];
    Timeline1ViewController *timelineVC = (Timeline1ViewController*)navigationVC.topViewController;
    
    NSString* chosenCategory = [self.categoriesTextArray objectAtIndex:indexPath.row];
    NSLog(@"%@ CollectionCell was chosen", chosenCategory);
    timelineVC.category = chosenCategory;
    [self presentViewController:navigationVC animated:YES completion:nil];
}

#pragma mark - button that redirects us to the newTaskViewController
- (IBAction)addTaskAction:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"newTask" bundle:nil];
    UINavigationController *navigationVC = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"newTaskViewController"];
    
    [self presentViewController:navigationVC animated:YES completion:nil];
    
    
}

#pragma mark - Logs user out
- (IBAction)LogoutActionButton:(id)sender {
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    
    
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
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
