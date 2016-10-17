//
//  QuestionTableCell.h
//  vstreaming
//
//  Created by developer on 7/24/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"

@protocol QuestionCellDelegate

-(void) didAnswerBtnPressed:(int) questionID questionIndex:(int) index;

@end

@interface QuestionTableCell : UITableViewCell
-(void) setScreenMode:(LiveStreamingScreenMode) mode;
-(void) initCell:(Question *) cellData questionIndex:(int) index;

@property (assign, nonatomic) id <QuestionCellDelegate>delegate;
@end
