//
//  ExpertTableCell.m
//  vstreaming
//
//  Created by developer on 7/24/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "ExpertTableCell.h"
@interface ExpertTableCell()
@property (weak, nonatomic) IBOutlet UITextField *companyName;
@property (weak, nonatomic) IBOutlet UITextField *title;
@property (weak, nonatomic) IBOutlet UITextField *descriptField;

@end
@implementation ExpertTableCell

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
    [_descriptField setText:cellData.descriptionTxt];
    self.companyName.userInteractionEnabled = NO;
}
@end
