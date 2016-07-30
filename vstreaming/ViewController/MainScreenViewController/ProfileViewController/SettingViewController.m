//
//  SettingViewController.m
//  vstreaming
//
//  Created by developer on 7/28/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "SettingViewController.h"
#import "OtherSettingViewController.h"
@implementation SettingViewController
- (IBAction)backBtnClicked:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnPrivacyClicked:(id)sender {
    OtherSettingViewController *setting = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"OtherSettingViewController"];
    
    [setting setSelectedTab:Privacy_Policy];
    [self.navigationController pushViewController:setting animated:YES];
    
}
- (IBAction)btnRuleClicked:(id)sender {
    OtherSettingViewController *setting = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"OtherSettingViewController"];
    [setting setSelectedTab:Rules_Info];
    [self.navigationController pushViewController:setting animated:YES];
}
- (IBAction)btnTermsClicked:(id)sender {
    OtherSettingViewController *setting = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"OtherSettingViewController"];
    [setting setSelectedTab:Terms_Service];
    [self.navigationController pushViewController:setting animated:YES];
}
@end
