//
//  EditPasswordViewController.m
//  TaskU
//
//  Created by panzaldo on 7/18/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "EditPasswordViewController.h"
#import "Parse/Parse.h"

@interface EditPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *passwordLabel;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordLabel;

@end

@implementation EditPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


-(void)checkPassword{
    if (![self.passwordLabel.text isEqual:self.confirmPasswordLabel.text]){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid Password"
                                                                       message:@"Both Passwords must match."
                                                                preferredStyle:(UIAlertControllerStyleAlert)];
        
        // create an OK action
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                         }];
        [alert addAction:okAction];
        
        [self presentViewController:alert animated:YES completion:^{
        }];
    } else {
        //Change the new password
        PFUser *user = [PFUser currentUser];
        user.password = self.confirmPasswordLabel.text;
        [user saveInBackground];
        [self dismissViewControllerAnimated:YES completion:^{}];
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
- (IBAction)onSave:(UIButton *)sender {
    [self checkPassword];
    [self performSegueWithIdentifier:@"UnwindToProfile2" sender:self];

}

@end
