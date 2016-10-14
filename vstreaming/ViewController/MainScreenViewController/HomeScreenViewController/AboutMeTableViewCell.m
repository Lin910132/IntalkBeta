//
//  AboutMeTableViewCell.m
//  vstreaming
//
//  Created by developer on 10/14/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "AboutMeTableViewCell.h"

@implementation AboutMeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initCell:(Expert *)cellData{
    [_companyName setText:cellData.company];
    [_title setText:cellData.title];
    [_descriptTxt setText:cellData.descriptionTxt];
    self.companyName.userInteractionEnabled = NO;
}
@end
