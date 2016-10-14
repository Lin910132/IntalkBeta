//
//  ExpertSearchTableCell.m
//  vstreaming
//
//  Created by developer on 7/29/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "ExpertSearchTableCell.h"
#import <UIImageView+AFNetworking.h>
@implementation ExpertSearchTableCell
-(void)initCell:(User *)expert{
    [self.avatar layoutIfNeeded];
    self.avatar.layer.cornerRadius = self.avatar.frame.size.height / 2;
    self.avatar.layer.masksToBounds = YES;
    
    [self.avatar setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:expert.avatar_url]]
                        placeholderImage:nil
                                 success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                     [self.avatar setImage:image];
                                 }
                                 failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                 }];
    
    [self.name setText:expert.name];
    [self.title setText:expert.title];
}
@end
