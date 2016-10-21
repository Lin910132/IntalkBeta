//
//  ExpertSearchTableCell.m
//  vstreaming
//
//  Created by developer on 7/29/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "ExpertSearchTableCell.h"
#import <UIImageView+AFNetworking.h>
#import "HomeTableItemModel.h"
@implementation ExpertSearchTableCell
-(void)initCell:(id)expert selectedTab:(int)selTab{
    [self.avatar layoutIfNeeded];
    self.avatar.layer.cornerRadius = self.avatar.frame.size.height / 2;
    self.avatar.layer.masksToBounds = YES;
    
    
    if(selTab == Expert_Tab) {
        User * expertUser = (User *) expert;
        [self.avatar setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:expertUser.avatar_url]]
                           placeholderImage:nil
                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                        [self.avatar setImage:image];
                                    }
                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                    }];
        
        [self.name setText:expertUser.name];
        [self.title setText:expertUser.title];
    }else{
        HomeTableItemModel * showResult = (HomeTableItemModel *) expert;
        [self.avatar setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:showResult.avatar_url]]
                           placeholderImage:nil
                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                        [self.avatar setImage:image];
                                    }
                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                    }];

        [self.name setText:showResult.title];
        [self.title setText:showResult.name];
    }
}
@end
