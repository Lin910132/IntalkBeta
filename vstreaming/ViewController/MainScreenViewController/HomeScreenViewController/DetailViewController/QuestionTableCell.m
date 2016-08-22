//
//  QuestionTableCell.m
//  vstreaming
//
//  Created by developer on 7/24/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "QuestionTableCell.h"

@interface QuestionTableCell()
@property (weak, nonatomic) IBOutlet UIButton *answer_normal_1;
@property (weak, nonatomic) IBOutlet UIButton *answer_normal_2;
@property (weak, nonatomic) IBOutlet UIButton *share1;
@property (weak, nonatomic) IBOutlet UIButton *share2;

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
        [_answer_normal_1 setHidden:YES];
        [_answer_normal_2 setHidden:YES];
    }
}
@end
