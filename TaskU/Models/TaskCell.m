//
//  TaskCell.m
//  TaskU
//
//  Created by lucyyyw on 7/16/19.
//  Copyright © 2019 rhaypapenfuzz. All rights reserved.
//

#import "TaskCell.h"
#import "DetailsViewController.h"

@implementation TaskCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)onClickDetails:(id)sender {
    [self.delegate didTapDetails:self];
}

- (instancetype) initWithTask:(Task *)task {
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end
