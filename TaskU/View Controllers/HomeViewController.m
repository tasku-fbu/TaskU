//
//  HomeViewController.m
//  TaskU
//
//  Created by rhaypapenfuzz on 7/15/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "SWRevealViewController.h"
#import "HomeViewController.h"
#import "HomeHeaderView.h"
#import "UIButtonExtension.h"
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
@property (weak, nonatomic) IBOutlet UIButton *plusButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *logoutButton;

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

    
    //Button configs
    self.plusButton.layer.shadowColor = [UIColor grayColor].CGColor;
    self.plusButton.layer.shadowOffset = CGSizeMake(10, 10);
    self.plusButton.layer.shadowOpacity = 0.5;
    self.plusButton.layer.shadowRadius = 5;
    self.plusButton.layer.masksToBounds = NO;
    self.plusButton.layer.cornerRadius = 26;
    self.plusButton.backgroundColor = [UIColor colorNamed:@"blue"];
 
    //Programatically sizing cols
    CGFloat spacing = 15;
    UICollectionViewFlowLayout *flow = (UICollectionViewFlowLayout*)self.collection_View.collectionViewLayout;
    flow.sectionInset = UIEdgeInsetsMake(0, spacing, 0, spacing);
    CGFloat itemsPerRow = 2;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat oneMore = itemsPerRow + 1;
    CGFloat width = screenRect.size.width - spacing * oneMore;
    CGFloat height = (width / itemsPerRow) ;

    flow.itemSize = CGSizeMake(floor(height ), height);
    flow.minimumInteritemSpacing = spacing;
    flow.minimumLineSpacing = spacing;

    //Navigation Controller Font
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor blackColor],
       NSFontAttributeName:[UIFont fontWithName:@"Quicksand-Bold" size:19]}];


    //Navigation Controller Font
    [self.logoutButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:@"Quicksand-Regular" size:18.0], NSFontAttributeName,nil] forState:UIControlStateNormal];

    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sideButton setTarget: self.revealViewController];
        [self.sideButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}

//Implementation for Header of Collection View
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        HomeHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeHeaderView" forIndexPath:indexPath];
        NSString *title = [[NSString alloc]initWithFormat:@"I can help with..."];
        headerView.title.text = title;
        
        reusableview = headerView;
    }
    
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        
        reusableview = footerview;
    }
    
    return reusableview;
    
}

#pragma mark - location button action
//[self.view addSubview:self.profileButton]; //slideMenu
// [self createInitialSlideView];



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
    
    
    //Cell shadow
    cell.contentView.layer.cornerRadius = 2.0f;
    cell.contentView.layer.borderWidth = 1.0f;
    cell.contentView.layer.borderColor = [UIColor clearColor].CGColor;
    cell.contentView.layer.masksToBounds = YES;
    
    cell.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    cell.layer.shadowOffset = CGSizeMake(0, 2.0f);
    cell.layer.shadowRadius = 2.0f;
    cell.layer.shadowOpacity = 0.5f;
    cell.layer.masksToBounds = NO;
    cell.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds cornerRadius:cell.contentView.layer.cornerRadius].CGPath;
    
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

//- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
//    <#code#>
//}
//
//- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
//    <#code#>
//}
//
//- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
//    <#code#>
//}
//
//- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
//    <#code#>
//}
//
//- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
//    <#code#>
//}
//
//- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
//    <#code#>
//}
//
//- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
//    <#code#>
//}
//
//- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
//    <#code#>
//}
//
//- (void)setNeedsFocusUpdate {
//    <#code#>
//}
//
//- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context {
//    <#code#>
//}
//
//- (void)updateFocusIfNeeded {
//    <#code#>
//}

@end
