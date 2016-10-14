//
//  HomeTableViewCell.h
//  vstreaming
//
//  Created by developer on 7/23/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeTableViewCellDelegate
-(void)didSelectTagButton:(NSInteger)tagID;
@end

@interface HomeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgLogo;
@property (weak, nonatomic) IBOutlet UIView *viewCountView;
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
@property (weak, nonatomic) IBOutlet UITextView *txtDescription;

-(void)setDataToCell:(NSMutableDictionary *) cellData cellType:(int) type;
-(void)initUI;
@property(nonatomic, retain) id<HomeTableViewCellDelegate> delegate;
@end
