//
//  MessageTableViewCell.h
//  vstreaming
//
//  Created by developer on 7/24/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"
@interface MessageReceiveCell : UITableViewCell
-(void)initCell:(Message*)cellData;
@end
