//
//  ExpertTableCell.h
//  vstreaming
//
//  Created by developer on 7/27/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ProfileExpertTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *companyName;
@property (weak, nonatomic) IBOutlet UITextField *title;

@property (weak, nonatomic) IBOutlet UITextField *descriptField;

-(void)initCell:(User*) user;
@end
