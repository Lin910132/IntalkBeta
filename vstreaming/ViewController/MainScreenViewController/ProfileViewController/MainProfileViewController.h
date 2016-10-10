//
//  MainProfileViewController.h
//  vstreaming
//
//  Created by developer on 7/25/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *userID;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIButton *userFollower;
@property (weak, nonatomic) IBOutlet UIButton *userFollowing;
@property (weak, nonatomic) IBOutlet UIImageView *userLogo;
@property (weak, nonatomic) IBOutlet UILabel *userShow;
@property (weak, nonatomic) IBOutlet UILabel *userLevel;
@property (weak, nonatomic) IBOutlet UILabel *userIncome;
@property (weak, nonatomic) IBOutlet UILabel *userBalance;
@property (weak, nonatomic) IBOutlet UIButton *follower;
@property (weak, nonatomic) IBOutlet UIButton *following;

@end
