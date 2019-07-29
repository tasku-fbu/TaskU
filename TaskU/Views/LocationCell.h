//
//  LocationCell.h
//  TaskU
//
//  Created by rhaypapenfuzz on 7/21/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Location Cell interface and method declaration
@interface LocationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) NSDictionary *location;
- (void)updateWithLocation:(NSDictionary *)location;

@end

NS_ASSUME_NONNULL_END
