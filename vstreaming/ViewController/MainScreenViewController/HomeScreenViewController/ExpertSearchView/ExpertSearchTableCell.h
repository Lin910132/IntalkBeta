//
//  ExpertSearchTableCell.h
//  vstreaming
//
//  Created by developer on 7/29/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpertSearchTableCell : UITableViewCell
-(void)initCell:(User *) expert;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;

@end
