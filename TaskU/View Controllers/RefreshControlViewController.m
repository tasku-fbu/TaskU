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

@end

@implementation RefreshControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame = CGRectMake(10, 10, 100, 100);
 
    CustomRefreshControl *refreshControl = [[CustomRefreshControl alloc] initWithFrame:frame];
    
    refreshControl.tag = 101;  //tag: int used to identify view objects in your application.
    [self.view addSubview:refreshControl];

    refreshControl.center = self.view.center;
    
    [self performSelector:@selector(animateProgress) withObject:nil afterDelay:0.5];
    
    //TODO: When to add image?
 //   [refreshControl addCheckImage];
    
}

-(void)animateProgress{
    CustomRefreshControl *refresh = [self.view viewWithTag:101];
    [refresh setProgressWithAnimation:3.0 withValue:1];
}



@end
