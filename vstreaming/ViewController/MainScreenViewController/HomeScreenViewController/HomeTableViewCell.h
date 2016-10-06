//
//  HomeTableViewCell.h
//  vstreaming
//
//  Created by developer on 7/23/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgLogo;
@property (weak, nonatomic) IBOutlet UILabel *viewCountInfo;
@property (weak, nonatomic) IBOutlet UILabel *itemTitle;
@property (weak, nonatomic) IBOutlet UILabel *itemContent;
@property (weak, nonatomic) IBOutlet UILabel *likesCount;
@property (weak, nonatomic) IBOutlet UIButton *tag1;
@property (weak, nonatomic) IBOutlet UIButton *tag2;
@property (weak, nonatomic) IBOutlet UIButton *tag3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tag1WidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tag2WidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tag3WidthConstraint;

-(void)setDataToCell:(NSMutableDictionary *) cellData cellType:(int) type;
@end
