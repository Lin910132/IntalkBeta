//
//  HomeTableViewCell.m
//  vstreaming
//
//  Created by developer on 7/23/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "HomeTableItemModel.h"
#import <UIImageView+AFNetworking.h>
@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) initUI{
    [self.viewCountInfo setHidden:YES];
    [self.viewCountView setHidden:YES];
}
- (CGFloat)widthOfString:(NSString *)string withFont:(UIFont *)font {
    
    NSDictionary *userAttributes = @{NSFontAttributeName: font,
                                     NSForegroundColorAttributeName: [UIColor blackColor]};
    const CGSize textSize = [string sizeWithAttributes: userAttributes];
    return textSize.width;
}

- (void)setDataToCell:(HomeTableItemModel *)cellData cellType:(int)type{
    [self.imgLogo setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:cellData.img_url]]
                        placeholderImage:nil
                                 success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                     [self.imgLogo setImage:image];
                                 }
                                 failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                 }];
    
    if(type == PreviewCell){
        self.itemTitle.text = cellData.name;
    }else if(type == LiveStramCell){
        if(cellData.tag1_id != 0){ //if not empty
            [self.tag1 setTitle:[[DataManager getInstance] findTagByID:cellData.tag1_id] forState:UIControlStateNormal];
            self.tag1WidthConstraint.constant = [self widthOfString:[[DataManager getInstance] findTagByID:cellData.tag1_id] withFont:[UIFont systemFontOfSize:12.0]];
        }else{
            [self.tag1 setHidden:YES];
        }
        
        if(cellData.tag2_id != 0){ //if not empty
            [self.tag2 setTitle:[[DataManager getInstance] findTagByID:cellData.tag2_id] forState:UIControlStateNormal];
            self.tag2WidthConstraint.constant = [self widthOfString:[[DataManager getInstance] findTagByID:cellData.tag2_id] withFont:[UIFont systemFontOfSize:12.0]];
            
        }else{
            [self.tag2 setHidden:YES];
        }
        
        if(cellData.tag3_id != 0){ //if not empty
            [self.tag3 setTitle:[[DataManager getInstance] findTagByID:cellData.tag3_id] forState:UIControlStateNormal];
            self.tag3WidthConstraint.constant = [self widthOfString:[[DataManager getInstance] findTagByID:cellData.tag3_id] withFont:[UIFont systemFontOfSize:12.0]];
            
        }else{
            [self.tag3 setHidden:YES];
        }
        
        [self.viewCountInfo setText:[NSString stringWithFormat:@"%dk Views", cellData.viewCount]];
        [self.imgLogo setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:cellData.avatar_url]]
                             placeholderImage:nil
                                      success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                          [self.imgLogo setImage:image];
                                      }
                                      failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                      }];
        [self.itemContent setText:cellData.descriptText];
        [self.itemTitle setText:cellData.title];
    }else{
        if(cellData.tag1_id != 0){ //if not empty
            [self.tag1 setTitle:[[DataManager getInstance] findTagByID:cellData.tag1_id] forState:UIControlStateNormal];
            self.tag1WidthConstraint.constant = [self widthOfString:[[DataManager getInstance] findTagByID:cellData.tag1_id] withFont:[UIFont systemFontOfSize:12.0]];
        }else{
            [self.tag1 setHidden:YES];
        }
        
        if(cellData.tag2_id != 0){ //if not empty
            [self.tag2 setTitle:[[DataManager getInstance] findTagByID:cellData.tag2_id] forState:UIControlStateNormal];
            self.tag2WidthConstraint.constant = [self widthOfString:[[DataManager getInstance] findTagByID:cellData.tag2_id] withFont:[UIFont systemFontOfSize:12.0]];
            
        }else{
            [self.tag2 setHidden:YES];
        }
        
        if(cellData.tag3_id != 0){ //if not empty
            [self.tag3 setTitle:[[DataManager getInstance] findTagByID:cellData.tag3_id] forState:UIControlStateNormal];
            self.tag3WidthConstraint.constant = [self widthOfString:[[DataManager getInstance] findTagByID:cellData.tag3_id] withFont:[UIFont systemFontOfSize:12.0]];
            
        }else{
            [self.tag3 setHidden:YES];
        }
        
        [self.viewCountInfo setText:[NSString stringWithFormat:@"%dk Views", cellData.viewCount]];
        [self.imgLogo setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:cellData.avatar_url]]
                            placeholderImage:nil
                                     success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                         [self.imgLogo setImage:image];
                                     }
                                     failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                     }];
        [self.itemContent setText:cellData.descriptText];
        [self.itemTitle setText:cellData.title];
    }
}

#pragma mark - outlets
- (IBAction)tagPressed:(id)sender {
    UIButton* pressedBtn = (UIButton *) sender;
    if(self.delegate){
        [self.delegate didSelectTagButton:pressedBtn.tag];
    }
}

@end
