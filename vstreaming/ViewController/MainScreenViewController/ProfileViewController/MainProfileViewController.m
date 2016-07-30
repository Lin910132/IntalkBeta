//
//  MainProfileViewController.m
//  vstreaming
//
//  Created by developer on 7/25/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "MainProfileViewController.h"
#import "FollowInformationViewController.h"
@implementation MainProfileViewController
- (IBAction)btnFollowerClicked:(id)sender {
    FollowInformationViewController *followInfoVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"FollowInformationViewController"];
    [self presentViewController:followInfoVC animated:YES completion:nil];
}

- (IBAction)btnFollowingClicked:(id)sender {
    FollowInformationViewController *followInfoVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"FollowInformationViewController"];
    [self presentViewController:followInfoVC animated:YES completion:nil];
}
@end
