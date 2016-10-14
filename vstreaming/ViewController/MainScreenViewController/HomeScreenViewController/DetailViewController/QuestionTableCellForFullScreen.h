//
//  QuestionTableCellForFullScreen.h
//  vstreaming
//
//  Created by developer on 10/12/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"
@interface QuestionTableCellForFullScreen : UITableViewCell
-(void) setScreenMode:(LiveStreamingScreenMode) mode;
-(void) initCell:(Question *) cellData;
@end
