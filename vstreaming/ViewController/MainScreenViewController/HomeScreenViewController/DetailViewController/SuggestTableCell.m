//
//  SuggestTableCell.m
//  vstreaming
//
//  Created by developer on 7/24/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "SuggestTableCell.h"
@interface SuggestTableCell()
@property (weak, nonatomic) IBOutlet UIButton *startTime;
@property (weak, nonatomic) IBOutlet UIButton *duration;
@property (weak, nonatomic) IBOutlet UIButton *answeredQuestion;

@end
@implementation SuggestTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initUI:(int)answeredQuestion startTime:(NSString *)startTime startDate:(NSDate *) startDate{
    [self.startTime setTitle:startTime forState:UIControlStateNormal];
    [self.answeredQuestion setTitle:[NSString stringWithFormat:@"%d", answeredQuestion] forState:UIControlStateNormal];
    NSTimeInterval distanceBetweenDates = [[NSDate date] timeIntervalSinceDate:startDate];
    if(distanceBetweenDates < 60){
        [self.duration setTitle:[NSString stringWithFormat:@"%dS", (int)distanceBetweenDates] forState:UIControlStateNormal];
    }else{
        int min = distanceBetweenDates / 60;
        [self.duration setTitle:[NSString stringWithFormat:@"%dM", min] forState:UIControlStateNormal];
    }
}

@end
