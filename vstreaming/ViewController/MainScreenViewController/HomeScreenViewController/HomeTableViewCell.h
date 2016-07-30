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

-(void)setDataToCell:(NSMutableDictionary *) cellData;
@end
