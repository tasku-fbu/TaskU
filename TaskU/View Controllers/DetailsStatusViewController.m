//
//  DetailsStatusViewController.m
//  TaskU
//
//  Created by lucyyyw on 7/17/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "DetailsStatusViewController.h"
#import "Timeline1ViewController.h"
#import "ChatMessagesViewController.h"

#import <MapKit/MapKit.h>
#import "LocationsViewController.h"
#import "Task.h"



#pragma mark - interface and properties
@interface DetailsStatusViewController ()

//Labels
@property (weak, nonatomic) IBOutlet UILabel *createLabel;
@property (weak, nonatomic) IBOutlet UILabel *acceptLabel;
@property (weak, nonatomic) IBOutlet UILabel *completeLabel;
@property (weak, nonatomic) IBOutlet UILabel *payLabel;

//Action Buttons
@property (weak, nonatomic) IBOutlet UIButton *acceptButton;
@property (weak, nonatomic) IBOutlet UIButton *completeButton;
@property (weak, nonatomic) IBOutlet UIButton *payButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelRequestButton;

//Contact buttons
@property (weak, nonatomic) IBOutlet UIButton *contactMissioner;
@property (weak, nonatomic) IBOutlet UIButton *contactRequester;


//Past Views
@property (weak, nonatomic) IBOutlet UIImageView *createIconView;
@property (weak, nonatomic) IBOutlet UIImageView *acceptIconView;
@property (weak, nonatomic) IBOutlet UIImageView *completeIconView;
@property (weak, nonatomic) IBOutlet UIImageView *payIconView;

//Map View Properties
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) NSNumber *latitude;
@property (weak, nonatomic) NSNumber *longitude;


//Side buttons to display timeline
@property (weak, nonatomic) IBOutlet UIButton *createButton;
@property (weak, nonatomic) IBOutlet UIButton *acceptMissionButton;
@property (weak, nonatomic) IBOutlet UIButton *completedMissionButton;
@property (weak, nonatomic) IBOutlet UIButton *paidMissionButton;



@end
static NSString *const searchLocationSegueIdentifier = @"searchLocationSegue";
NSMutableArray *annotationsArray;

@implementation DetailsStatusViewController


#pragma mark - Details Status intial View
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self showCreateLabel];
    [self updateView];
    [self buttonRadiusHelper];
    [self showContactInfoButton];
    
    self.cancelRequestButton.layer.cornerRadius = 10;
    self.acceptButton.layer.cornerRadius = 10;
    
    //one degree of latitude is approximately 111 kilometers (69 miles) at all times.
   //MKCoordinateRegion schoolRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake([self.task.endLatitude doubleValue], [self.task.endLongitude doubleValue]), MKCoordinateSpanMake(1.9, 1.9));
    //[self.mapView setRegion:schoolRegion animated:NO];

    annotationsArray = [NSMutableArray new];
    
    if(!(self.task.startLatitude == nil) || !(self.task.startLongitude == nil)){
        MKPointAnnotation *startAnnotation = [MKPointAnnotation new];
        startAnnotation.coordinate = CLLocationCoordinate2DMake([self.task.startLatitude  doubleValue], [self.task.startLongitude doubleValue]);
        startAnnotation.title = @"Starts Here!";
        [annotationsArray addObject:startAnnotation];
    //[self.mapView addAnnotation:startAnnotation];
    }
    
    MKPointAnnotation *endAnnotation = [MKPointAnnotation new];
    endAnnotation.coordinate = CLLocationCoordinate2DMake([self.task.endLatitude doubleValue], [self.task.endLongitude doubleValue]);
    endAnnotation.title = @"Delivery Point!";
    [annotationsArray addObject:endAnnotation];
    //[self.mapView showAnnotations:annotationsArray animated:YES];
    
    
    
    UISwipeGestureRecognizer *toRightSwipeRecognizer = [[[UISwipeGestureRecognizer alloc] init] initWithTarget:self action:@selector(slideToRightWithGestureRecognizer:)];
    toRightSwipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:toRightSwipeRecognizer];
}



/*
- (void) slideToLeftWithGestureRecognizer:(UISwipeGestureRecognizer *) gestureRecognizer {
    
    CATransition *transition = [CATransition animation];
    transition.duration = 1;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:transition forKey:nil];
    [self dismissViewControllerAnimated:NO completion:nil];
    
    
}
 */


- (void) slideToRightWithGestureRecognizer:(UISwipeGestureRecognizer *) gestureRecognizer {
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.75;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:transition forKey:nil];
    
        self.tabBarController.selectedIndex += 1;
}

-(void) viewDidAppear:(BOOL)animated{
    [self.mapView showAnnotations:annotationsArray animated:YES];
    
}
-(void)buttonRadiusHelper{
    self.createButton.layer.cornerRadius = 18;
    self.acceptMissionButton.layer.cornerRadius = 18;
    self.acceptMissionButton.layer.cornerRadius = 18;
    self.paidMissionButton.layer.cornerRadius = 18;
    self.completedMissionButton.layer.cornerRadius = 18;
    
    self.contactMissioner.layer.cornerRadius = 10;
    self.contactRequester.layer.cornerRadius = 10;

}
- (IBAction)OnClickContactMissioner:(id)sender {
    [self contact:self.task[@"missioner"]];
}
- (IBAction)OnClickContactRequester:(id)sender {
    [self contact:self.task[@"requester"]];
}

//Contact button hidden unless someone accepted  task
-(void)showContactInfoButton{
    self.contactMissioner.hidden = YES;
    self.contactRequester.hidden = YES;
    self.contactMissioner.userInteractionEnabled = NO;
    self.contactRequester.userInteractionEnabled = NO;
    
    [self.contactMissioner.titleLabel setFont:[UIFont fontWithName:@"Quicksand" size:12.0f]];
    
    [self.contactRequester.titleLabel setFont:[UIFont fontWithName:@"Quicksand" size:12.0f]];
    
    NSString *status = self.task[@"completionStatus"];
    PFUser *me = [PFUser currentUser];
    PFUser *requester = self.task[@"requester"];
    PFUser *missioner = self.task[@"missioner"];
    if (missioner) {
        if (![status isEqualToString:@"paid"]) {
            if ([me.objectId isEqualToString:requester.objectId]) {
                self.contactMissioner.hidden = NO;
                self.contactMissioner.userInteractionEnabled = YES;
            } else if ([me.objectId isEqualToString:missioner.objectId]){
                self.contactRequester.hidden = NO;
                self.contactRequester.userInteractionEnabled = YES;
            }
            
            
            
            
        }
    }
    
    
}


#pragma mark - mapView Annotation
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *annotationView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Pin"];
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Pin"];
        annotationView.canShowCallout = true;
        annotationView.leftCalloutAccessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 5.0, 5.0)];
    }
    
    UIImageView *imageView = (UIImageView*)annotationView.leftCalloutAccessoryView;
    imageView.image = [UIImage imageNamed:@"location"];
    
    return annotationView;
}

#pragma mark - Gets user selected location's coordinates and resets annotation
- (void)locationsViewController:(nonnull LocationsViewController *)controller didPickLocationWithLatitude:(nonnull NSNumber *)latitude longitude:(nonnull NSNumber *)longitude {
    self.latitude = latitude;
    self.longitude = longitude;
    [self reloadMap];
    [self dismissViewControllerAnimated:true completion:nil];
   // [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
}

-(void) reloadMap {
    MKCoordinateRegion schoolRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake([self.latitude doubleValue],[self.longitude doubleValue]), MKCoordinateSpanMake(0.05, 0.05));
    [self.mapView setRegion:schoolRegion animated:false];
    
    MKPointAnnotation *annotation = [MKPointAnnotation new];
    //annotation.coordinate = CLLocationCoordinate2DMake((double)(38.922777),(double)( -77.019445));
    annotation.coordinate = CLLocationCoordinate2DMake([self.latitude doubleValue],[self.longitude doubleValue]);
    annotation.title = @"Picture!";
    [self.mapView addAnnotation:annotation];
}

- (void) showCreateLabel {
    PFUser *requester = self.task[@"requester"];
    NSString *username = requester.username;
    
    NSString *dateString = [self stringfromDateHelper:self.task.createdAt];
    NSString *display = [NSString stringWithFormat:@"Created by requester @%@ on %@", username, dateString];
    self.createLabel.text = display;
}



- (void) showAcceptLabel {
    PFUser *missioner = self.task[@"missioner"];
    if (!missioner || [missioner isEqual:[NSNull null]]) {
        self.acceptLabel.text = @"Still awaiting for a missioner!";
        self.acceptLabel.textColor = [UIColor grayColor];
    } else {
        self.acceptLabel.textColor = [UIColor blackColor];
        NSString *username = missioner.username;
        NSString *dateString = [self stringfromDateHelper:self.task[@"acceptedAt"]];
        NSString *display = [NSString stringWithFormat:@"Accepted by missioner @%@ on %@", username, dateString];
        self.acceptLabel.text = display;
    }
}

- (void) showAcceptButton {
    PFUser *missioner = self.task[@"missioner"];
    PFUser *requester = self.task[@"requester"];
    self.acceptButton.layer.cornerRadius = 10;
    if ([[PFUser currentUser].objectId isEqual:requester.objectId]) {
        self.acceptButton.hidden = YES;
        self.acceptButton.userInteractionEnabled = NO;
    } else if (!missioner || [missioner isEqual:[NSNull null]]) {
        self.acceptButton.hidden = NO;
        self.acceptButton.userInteractionEnabled = YES;
        [self.acceptButton setTitle:@"Accept" forState:UIControlStateNormal];
      
        [self updateButtonStatusHelper:self.acceptButton];

    } else if ([missioner.objectId isEqual:[PFUser currentUser].objectId] && [self.task[@"completionStatus"] isEqualToString:@"accepted"]) {
        self.acceptButton.hidden = NO;
        self.acceptButton.userInteractionEnabled = YES;
        [self.acceptButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [self.acceptButton setBackgroundColor:[UIColor redColor]];
        [self.acceptButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
         [self.cancelRequestButton.titleLabel setFont:[UIFont fontWithName:@"Quicksand" size:17.0f]];
    } else {
        self.acceptButton.hidden = YES;
        self.acceptButton.userInteractionEnabled = NO;
    }
}

- (void) showCompleteButton {
    PFUser *missioner = self.task[@"missioner"];
    //PFUser *requester = self.task[@"requester"];
    self.completeButton.layer.cornerRadius = 10;

    if (self.task[@"acceptedAt"] && ![self.task[@"acceptedAt"] isEqual:[NSNull null]] && (!self.task[@"completedAt"] || [self.task[@"completedAt"] isEqual:[NSNull null]])) {
        if ([[PFUser currentUser].objectId isEqual:missioner.objectId]) {
            self.completeButton.hidden = NO;
            self.completeButton.userInteractionEnabled = YES;
            [self.completeButton setTitle:@"Complete" forState:UIControlStateNormal];
            [self updateButtonStatusHelper:self.completeButton];
            
        } /*
        else if ([[PFUser currentUser].objectId isEqual:requester.objectId]) {
            self.completeButton.hidden = YES;
            self.completeButton.userInteractionEnabled = NO;
           
            [self.completeButton setTitle:@"Contact missioner" forState:UIControlStateNormal];
            [self.completeButton setBackgroundColor:[UIColor colorWithRed:0.9 green:0.3 blue:0 alpha:1.0]];
            [self.completeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
           
        } */else {
            self.completeButton.hidden = YES;
            self.completeButton.userInteractionEnabled = NO;
        }
    } else {
        self.completeButton.hidden = YES;
        self.completeButton.userInteractionEnabled = NO;
    }
    
    
}


//Sets the button color to be green, round corners and white text
-(void) updateButtonStatusHelper: (UIButton *) button {
    [button setBackgroundColor:[UIColor colorNamed:@"darkGreen"]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont fontWithName:@"Quicksand" size:17.0f]];
}

- (void) showCompleteLabel {
    PFUser *missioner = self.task[@"missioner"];
    NSDate *completedAt = self.task[@"completedAt"];
    
    if (!missioner || [missioner isEqual:[NSNull null]]) {
        self.completeLabel.text = @"Still awaiting for a missioner!";
        self.completeLabel.textColor = [UIColor grayColor];
    } else if (!completedAt || [completedAt isEqual:[NSNull null]]) {
        self.completeLabel.text = [NSString stringWithFormat:@"Still in progress by missioner @%@", missioner[@"username"]];
        self.completeLabel.textColor = [UIColor grayColor];
    } else {
        self.completeLabel.textColor = [UIColor blackColor];
        NSString *username = missioner.username;
        NSString *dateString = [self stringfromDateHelper:completedAt];
        NSString *display = [NSString stringWithFormat:@"Completed by missioner @%@ at @%@", username, dateString];
        self.completeLabel.text = display;
    }
}

- (void) showPayButton {
    PFUser *requester = self.task[@"requester"];
    PFUser *missioner = self.task[@"missioner"];
    self.payButton.layer.cornerRadius = 10;
    if ([self.task[@"completionStatus"] isEqualToString:@"completed"]) {
        if ([[PFUser currentUser].objectId isEqual:requester.objectId]) {
            self.payButton.hidden = NO;
            self.payButton.userInteractionEnabled = YES;
            [self.payButton setTitle:@"Confirm & Pay" forState:UIControlStateNormal];
            
            [self updateButtonStatusHelper:self.payButton];
        
        } /*else if ([[PFUser currentUser].objectId isEqualToString:missioner.objectId]){
            self.payButton.hidden = NO;
            self.payButton.userInteractionEnabled = YES;
            [self.payButton setTitle:@"Contact Requester" forState:UIControlStateNormal];
            [self.payButton setBackgroundColor:[UIColor colorWithRed:0.9 green:0.3 blue:0 alpha:1.0]];
            [self.payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        } */else {
            self.payButton.hidden = YES;
            self.payButton.userInteractionEnabled = NO;
        }
    } else if ([self.task[@"completionStatus"] isEqualToString:@"pay"]) {
        if ([[PFUser currentUser].objectId isEqual:missioner.objectId]) {
            self.payButton.hidden = NO;
            self.payButton.userInteractionEnabled = YES;
            [self.payButton setTitle:@"Confirm payment received" forState:UIControlStateNormal];
            [self updateButtonStatusHelper:self.payButton];
        }
    }
    
    
    else {
        self.payButton.hidden = YES;
        self.payButton.userInteractionEnabled = NO;
    }
    
}

- (void) showPayLabel {
    PFUser *requester = self.task[@"requester"];
    PFUser *missioner = self.task[@"missioner"];
    NSDate *completedAt = self.task[@"completedAt"];
    NSDate *paidAt = self.task[@"paidAt"];
    
    if (!missioner || [missioner isEqual:[NSNull null]]) {
        self.payLabel.text = @"Still awaiting for a missioner!";
        self.payLabel.textColor = [UIColor grayColor];
    } else if (!completedAt) {
        self.payLabel.text = [NSString stringWithFormat:@"Still in progress by missioner @%@", missioner[@"username"]];
        self.payLabel.textColor = [UIColor grayColor];
    } else if ([self.task[@"completionStatus"] isEqualToString:@"paid"]){
        self.payLabel.textColor = [UIColor blackColor];
        NSString *username = requester.username;
        NSString *dateString = [self stringfromDateHelper:paidAt];
        NSString *display = [NSString stringWithFormat:@"Paid by requester @%@ at %@", username, dateString];
        self.payLabel.text = display;
    } else if ([self.task[@"completionStatus"] isEqualToString:@"pay"]) {
        self.payLabel.text = [NSString stringWithFormat:@"Confirmed by requester @%@.\nAwaiting requester @%@ to complete payment...", requester[@"username"], requester[@"username"]];
        self.payLabel.textColor = [UIColor grayColor];
    }else {
        self.payLabel.text = [NSString stringWithFormat:@"Still awaiting confirmation from requester @%@...", requester[@"username"]];
        self.payLabel.textColor = [UIColor grayColor];
    }
}



- (NSString *) stringfromDateHelper: (NSDate *) date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE, MMM d @ HH:mm a"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}



- (IBAction)onTapAcceptButton:(id)sender {
    UIButton *btn = (UIButton *) sender;
    if (btn.hidden == NO) {
        PFUser *missioner = [PFUser currentUser];
        if ([btn.currentTitle isEqualToString:@"Accept"]) {
            
            self.task[@"missioner"] = missioner;
            
            
            self.task[@"acceptedAt"] = [NSDate date];
            self.task[@"completionStatus"] = @"accepted";
            
            [self.task saveInBackground];
            [self updateView];
            
            //Contact button shows and links to messaging
            self.contactRequester.hidden = NO;
         //   [self contact:self.task[@"missioner"]];
            
        } else if ([btn.currentTitle isEqualToString:@"Cancel"]) {
            
            self.task[@"missioner"] = [NSNull null];
            self.task[@"acceptedAt"] = [NSNull null];
            self.task[@"completionStatus"] = @"created";
            [self.missionDelegate didCancelMission];
            [self.task saveInBackground];
            [self updateView];
        }
    }
    
}

- (IBAction)onTapCompleteButton:(id)sender {
    UIButton *btn = (UIButton *) sender;
    if (btn.hidden == NO) {
        
        if ([btn.currentTitle isEqualToString:@"Complete"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Confirm Completion of Mission"
                                                                           message:@"Are you sure that you have completed the Mission?\nOnce confirmed you will no longer be able to change the status!"
                                                                    preferredStyle:(UIAlertControllerStyleAlert)];
            
            // create an OK action
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Confirm"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 NSLog(@"completedConfirmed");
                                                                 self.task[@"completedAt"] = [NSDate date];
                                                                 self.task[@"completionStatus"] = @"completed";
                                                                 [self.task saveInBackground];
                                                                 [self updateView];
                                                             }];
            UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 NSLog(@"cancelCompletion");
                                                             }];
            [alert addAction:okAction];
            [alert addAction:noAction];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
    
    
    
    
}
- (IBAction)onTapPayButton:(id)sender {
    UIButton *btn = (UIButton *) sender;
    if (btn.hidden == NO) {
        if ([btn.currentTitle isEqualToString:@"Confirm & Pay"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Continue to pay?"
                                                                           message:@"You will continue to paying the missioner once you confirm!"
                                                                    preferredStyle:(UIAlertControllerStyleAlert)];
            
            // create an OK action
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Confirm"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 NSLog(@"Confirm to pay");
                                                                 self.task[@"completionStatus"] = @"pay";
                                                                 [self.task saveInBackground];
                                                                 [self updateView];
                                                                 UIApplication *application = [UIApplication sharedApplication];
                                                                 NSURL *URL = [NSURL URLWithString:@"squarecash://"];
                                                                 [application openURL:URL options:@{} completionHandler:^(BOOL success) {
                                                                     if (success) {
                                                                         NSLog(@"Opened url");
                                                                     }
                                                                 }];
                                                             }];
            UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 NSLog(@"cancel to pay");
                                                             }];
            [alert addAction:okAction];
            [alert addAction:noAction];
            
            [self presentViewController:alert animated:YES completion:nil];
        } else if ([btn.currentTitle isEqualToString:@"Confirm payment received"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Confirm payment received"
                                                                           message:@"Once confirmed you will not be able to cancel confirmation."
                                                                    preferredStyle:(UIAlertControllerStyleAlert)];
            
            // create an OK action
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Confirm"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 NSLog(@"Confirm payment received");
                                                                 self.task[@"completionStatus"] = @"paid";
                                                                 self.task[@"paidAt"] = [NSDate date];
                                                                 [self.task saveInBackground];
                                                                 [self updateView];
                                                                 
                                                             }];
            UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 NSLog(@"cancel confirming payment received");
                                                             }];
            [alert addAction:okAction];
            [alert addAction:noAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
    
    
}

- (void) showCancelRequestButton {
    PFUser *requester = self.task[@"requester"];
    PFUser *me = [PFUser currentUser];
    NSString *status = self.task[@"completionStatus"];
    self.cancelRequestButton.layer.cornerRadius = 10;
    if ([me.objectId isEqualToString:requester.objectId] && ([status isEqualToString:@"created"] || [status isEqualToString:@"accepted"])) {
        self.cancelRequestButton.hidden = NO;
        self.cancelRequestButton.userInteractionEnabled = YES;
        [self.cancelRequestButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [self.cancelRequestButton setBackgroundColor:[UIColor redColor]];
        [self.cancelRequestButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.cancelRequestButton.titleLabel setFont:[UIFont fontWithName:@"Quicksand" size:17.0f]];

    } else {
        self.cancelRequestButton.hidden = YES;
        self.cancelRequestButton.userInteractionEnabled = NO;
    }
}


- (IBAction)onTapCancelRequest:(id)sender {
    UIButton *btn = (UIButton *) sender;
    if (btn.hidden == NO) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Confirm to Cancel Your Request "
                                                                       message:@"Are you sure that you want to cancel your request?\nYou will not be able to undo cancellation later!"
                                                                preferredStyle:(UIAlertControllerStyleAlert)];
        
        // create an OK action
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Confirm"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             NSLog(@"Confirm to cancel request");
                                                             
                                                             [self.task deleteInBackground];
                                                             [self.delegate didCancelRequest];
                                                             [self dismissViewControllerAnimated:YES completion:^{}];
                                                             
                                                             
                                                         }];
        UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             NSLog(@"cancel to cancel request");
                                                         }];
        [alert addAction:okAction];
        [alert addAction:noAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void) updateView {
    [self showAcceptButton];
    [self showAcceptLabel];
    [self showCompleteLabel];
    [self showPayLabel];
    [self showCompleteButton];
    [self showPayButton];
    [self showCancelRequestButton];
    [self updateStatusIcons];
}

- (void) updateStatusIcons{
    NSString *status = self.task[@"completionStatus"];
    if ([status isEqualToString:@"created"]) {
    
        //Current Status activated
        [self.createButton setImage:[UIImage imageNamed:@"checkmark"] forState:UIControlStateNormal];
        self.createButton.backgroundColor = [UIColor colorNamed:@"blue"];

        
        //Other status deactivated
        [self.acceptMissionButton setImage:[UIImage imageNamed:@"dot"] forState:UIControlStateNormal];
        self.acceptMissionButton.backgroundColor = [UIColor clearColor];

        [self.completedMissionButton setImage:[UIImage imageNamed:@"dot"] forState:UIControlStateNormal];
        [self.paidMissionButton setImage:[UIImage imageNamed:@"dot"] forState:UIControlStateNormal];
     
    }else if ([status isEqualToString:@"accepted"]) {
        [self.acceptMissionButton setImage:[UIImage imageNamed:@"checkmark"] forState:UIControlStateNormal];
        self.acceptMissionButton.backgroundColor = [UIColor colorNamed:@"blue"];
        
        [self.createButton setImage:[UIImage imageNamed:@"dot"] forState:UIControlStateNormal];
        self.createButton.backgroundColor = [UIColor whiteColor];

        [self.completedMissionButton setImage:[UIImage imageNamed:@"dot"] forState:UIControlStateNormal];
        [self.paidMissionButton setImage:[UIImage imageNamed:@"dot"] forState:UIControlStateNormal];
        
    } else if ([status isEqualToString:@"completed"]) {
        [self.completedMissionButton setImage:[UIImage imageNamed:@"checkmark"] forState:UIControlStateNormal];
        self.completedMissionButton.backgroundColor = [UIColor colorNamed:@"blue"];

        
        [self.createButton setImage:[UIImage imageNamed:@"dot"] forState:UIControlStateNormal];
        [self.acceptMissionButton setImage:[UIImage imageNamed:@"dot"] forState:UIControlStateNormal];
        self.acceptMissionButton.backgroundColor = [UIColor clearColor];

        [self.paidMissionButton setImage:[UIImage imageNamed:@"dot"] forState:UIControlStateNormal];
        
    } else {
        [self.paidMissionButton setImage:[UIImage imageNamed:@"checkmark"] forState:UIControlStateNormal];
        self.paidMissionButton.backgroundColor = [UIColor colorNamed:@"blue"];

        
        [self.createButton setImage:[UIImage imageNamed:@"dot"] forState:UIControlStateNormal];
        [self.acceptMissionButton setImage:[UIImage imageNamed:@"dot"] forState:UIControlStateNormal];
        [self.completedMissionButton setImage:[UIImage imageNamed:@"dot"] forState:UIControlStateNormal];
    }
    
}

- (void) contact:(PFUser *) otherUser {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Message" bundle:nil];
    ChatMessagesViewController *chatMessagesVC = (ChatMessagesViewController *)[storyboard instantiateViewControllerWithIdentifier:@"chatMessages"];
    chatMessagesVC.contact = otherUser;
    [self presentViewController:chatMessagesVC animated:YES completion:nil];
    
}



@end
