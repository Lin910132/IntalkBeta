//
//  QuestionTableCell.m
//  vstreaming
//
//  Created by developer on 7/24/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "QuestionTableCell.h"

@interface QuestionTableCell(){
    Question *question;
    int qIndex;
    LiveStreamingScreenMode screenMode;
}
@property (weak, nonatomic) IBOutlet UIButton *diamondBtn;
@property (weak, nonatomic) IBOutlet UIButton *answerBtn;
@property (weak, nonatomic) IBOutlet UILabel *questionContent;
@property (weak, nonatomic) IBOutlet UILabel *senderName;


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
//    if(mode == Streaming_Client){
//        [self.answerBtn setHidden:YES];
//    }
    screenMode = mode;
}

-(void)initCell:(Question *)cellData questionIndex:(int)index{
    question = cellData;
    qIndex = index;
    if(cellData.diamond == 0 ) {
        [self.diamondBtn setHidden:YES];
        [self.answerBtn setHidden:YES];
    }else{
        [self.diamondBtn setTitle:[NSString stringWithFormat:@"%d",cellData.diamond] forState:UIControlStateNormal];
    }
    if(screenMode != Streaming_Client){
        if(cellData.isAnswered){
            [self.answerBtn setHidden:YES];
        }else{
            [self.answerBtn setHidden:NO];
        }
    }
    
    [self.questionContent setText:cellData.question];
    [self.senderName setText:cellData.name];
}

- (IBAction)btnAnswerPressed:(id)sender {
    question.isAnswered = YES;
    if(self.delegate){
        [self.delegate didAnswerBtnPressed:question.questionID questionIndex:qIndex];
    }
    [(UIButton *) sender setHidden:YES];
}

@end
