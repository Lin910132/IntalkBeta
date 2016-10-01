//
//  MainProfileViewController.m
//  vstreaming
//
//  Created by developer on 7/25/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "MainProfileViewController.h"
#import "FollowInformationViewController.h"
@interface MainProfileViewController()
@end

@implementation MainProfileViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self showMyInfo];
}

#pragma mark - Outlets
- (IBAction)btnFollowerClicked:(id)sender {
    FollowInformationViewController *followInfoVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"FollowInformationViewController"];
    [self presentViewController:followInfoVC animated:YES completion:nil];
}

- (IBAction)btnFollowingClicked:(id)sender {
    FollowInformationViewController *followInfoVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"FollowInformationViewController"];
    [self presentViewController:followInfoVC animated:YES completion:nil];
}

#pragma mark - Private
-(void) showMyInfo{
    User* currentUser = [User getInstance];
    self.userID.text = [NSString stringWithFormat:@"ID: %d", currentUser.user_id];
    self.userName.text = currentUser.name;
    
}
@end
