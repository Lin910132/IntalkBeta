//
//  SuggestTableCell.h
//  vstreaming
//
//  Created by developer on 7/24/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuggestTableCell : UITableViewCell
-(void) initUI:(int) answeredQuestion startTime:(NSString *) startTime startDate:(NSDate*) startDate;
@end
