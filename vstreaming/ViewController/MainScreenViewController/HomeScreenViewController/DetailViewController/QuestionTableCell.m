//
//  QuestionTableCell.m
//  vstreaming
//
//  Created by developer on 7/24/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "QuestionTableCell.h"

@interface QuestionTableCell()
@property (weak, nonatomic) IBOutlet UIButton *diamondBtn;
@property (weak, nonatomic) IBOutlet UIButton *answerBtn;
@property (weak, nonatomic) IBOutlet UILabel *questionContent;


@end

@implementation QuestionTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setScreenMode:(LiveStreamingScreenMode)mode{
    if(mode == Streaming_Client){
        [self.answerBtn setHidden:YES];
    }
}

-(void)initCell:(Question *)cellData{
    [self.diamondBtn setTitle:[NSString stringWithFormat:@"%d",cellData.diamond] forState:UIControlStateNormal];
    [self.questionContent setText:cellData.question];
}
@end
