//
//  QuestionTableCellForFullScreen.m
//  vstreaming
//
//  Created by developer on 10/12/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "QuestionTableCellForFullScreen.h"
@interface QuestionTableCellForFullScreen()
@property (weak, nonatomic) IBOutlet UIButton *diamondBtn;
@property (weak, nonatomic) IBOutlet UIButton *answerBtn;
@property (weak, nonatomic) IBOutlet UILabel *questionContent;
@property (weak, nonatomic) IBOutlet UILabel *senderName;

@end
@implementation QuestionTableCellForFullScreen

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
    if(cellData.diamond == 0) {
        [self.diamondBtn setHidden:YES];
        [self.answerBtn setHidden:YES];
    }else{
        [self.diamondBtn setTitle:[NSString stringWithFormat:@"%d",cellData.diamond] forState:UIControlStateNormal];
    }
    
    [self.questionContent setText:cellData.question];
    [self.senderName setText:cellData.name];
}
@end
