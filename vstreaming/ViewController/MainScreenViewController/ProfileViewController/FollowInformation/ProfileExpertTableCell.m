//
//  ExpertTableCell.m
//  vstreaming
//
//  Created by developer on 7/27/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "ProfileExpertTableCell.h"
@interface ProfileExpertTableCell()
@property (weak, nonatomic) IBOutlet UIButton *btnFellow;

@end
@implementation ProfileExpertTableCell
- (IBAction)btnFellowClicked:(id)sender {
    [_btnFellow.titleLabel setFont:[UIFont boldSystemFontOfSize:14.f]];
}

@end
