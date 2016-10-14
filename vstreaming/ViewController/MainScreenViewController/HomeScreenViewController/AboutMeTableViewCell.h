//
//  AboutMeTableViewCell.h
//  vstreaming
//
//  Created by developer on 10/14/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Expert.h"
@interface AboutMeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *companyName;
@property (weak, nonatomic) IBOutlet UITextField *title;
@property (weak, nonatomic) IBOutlet UITextField *descriptTxt;
-(void) initCell:(Expert *) cellData;
@end
