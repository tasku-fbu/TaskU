//
//  RefreshControlViewController.m
//  TaskU
//
//  Created by panzaldo on 8/6/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "RefreshControlViewController.h"
#import "CustomRefreshControl.h"
#import "CustomRefresh.h"


@interface RefreshControlViewController ()
@property (strong, nonatomic) IBOutlet CustomRefresh *progressBar;

//@property (strong, nonatomic) IBOutlet CustomRefreshControl *anotherViwe;


@end

@implementation RefreshControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame = CGRectMake(10, 10, 100, 100);
 //   CustomRefresh *testingProgressBar = [[CustomRefresh alloc] initWithFrame:frame];
    
  //  self.progressBar = [[CustomRefresh alloc] initWithFrame:frame];
    
 //   self.progressBar = [[CustomRefresh alloc] initWithFrame:frame];

    CustomRefreshControl *anotherViwe = [[CustomRefreshControl alloc] initWithFrame:frame];
    
    anotherViwe.tag = 101;
//    [self.view addSubview:self.anotherViwe];
    [self.view addSubview:anotherViwe];

    anotherViwe.center = self.view.center;
    
  //  [anotherViwe setProgressWithAnimation:1 withValue:0];
    
   
    [self performSelector:@selector(animateProgress) withObject:nil afterDelay:2];
    [anotherViwe addCheckImage];
    
}

-(void)animateProgress{
    CustomRefreshControl *refresh = [self.view viewWithTag:101];
    [refresh setProgressWithAnimation:1.0 withValue:1];
    
}

    
  //  [self.progressBar setProgress:40 withAnimation:true];

    
//    [testingProgressBar setProgress:40 withAnimation:true];
    
  //  CGRect frame = CGRectMake(300, 0, 60, 60);
    



    //CustomRefreshControl *refreshControl = [[CustomRefreshControl alloc] initWithFrame:frame];
//
    
    
  //  [self.view addSubview:refreshControl];
    // Do any additional setup after loading the view.


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
