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
    if(mode == Streaming_Client){
        [self.answerBtn setHidden:YES];
    }
}

-(void)initCell:(Question *)cellData{
    question = cellData;
    if(cellData.diamond == 0) {
        [self.diamondBtn setHidden:YES];
        [self.answerBtn setHidden:YES];
    }else{
        [self.diamondBtn setTitle:[NSString stringWithFormat:@"%d",cellData.diamond] forState:UIControlStateNormal];
    }
    
    [self.questionContent setText:cellData.question];
    [self.senderName setText:cellData.name];
}

- (IBAction)btnAnswerPressed:(id)sender {
//    [InTalkAPI addAnswer:[ questionId:<#(int)#> answer:<#(NSString *)#> competion:<#^(NSDictionary *, NSError *)block#>]
}

@end
