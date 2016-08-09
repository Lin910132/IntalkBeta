//
//  BroadCastViewController.m
//  vstreaming
//
//  Created by developer on 7/24/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "BroadCastViewController.h"
#import "IndustrySelectViewController.h"
#import "DetailViewController.h"
#import "ExpertSubmitViewController.h"
#import "LiveStreaming.h"
@interface BroadCastViewController () <IndustrySelectDelegate>

@end

@implementation BroadCastViewController

- (IBAction)btnIndustryClicked:(id)sender {
    IndustrySelectViewController *industrySVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"IndustrySelectViewController"];
    [self presentViewController:industrySVC animated:YES completion:nil];
}
- (IBAction)backBtnClicked:(id)sender {
    [self.tabBarController setSelectedIndex:0]; // switch to main tab
}

- (IBAction)btnBeginClicked:(id)sender {
    /*DetailViewController *detailVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DetailViewController"];
    [self presentViewController:detailVC animated:YES completion:nil];
     */
    
    /*LiveStreaming *stream = [LiveStreaming sharedInstance];
  
    __weak typeof(self) weakSelf = self;
    
    [[stream getQAVContextInstance] startContext:^(QAVResult result) {
        if(result == QAV_OK){
            NSLog(@"startContext is OK");
            [[LiveStreaming sharedInstance]initTIMManager];
            TIMManager *imManager = [[LiveStreaming sharedInstance] getTIMManager];
            
            [imManager setConnListener:weakSelf];
            [imManager setRefreshListener:weakSelf];
            [imManager setUserStatusListener:weakSelf];
            
            TIMLoginParam * loginParam = [[TIMLoginParam alloc]init];
            loginParam.accountType = kSdkAccountType;
            loginParam.identifier = kIdentifier;
            loginParam.appidAt3rd = kSdkAppId;
            loginParam.userSig = [[TLSHelper getInstance]getTLSUserSig:kIdentifier];
            loginParam.sdkAppId = [kSdkAppId intValue];
            
            TIMFriendshipSetting *setting =  [[TIMFriendshipSetting alloc] init];
            setting.friendFlags = 0xFFFFFFFF;
            [imManager initFriendshipSetting:setting];
            [imManager enableFriendshipProxy];
            
            [imManager login:loginParam succ:^{
                NSLog(@"login success");
                
            } fail:^(int code, NSString *msg) {
                NSLog(@"login error code = %d",code);
            }];
        }
    }];*/    
    
    /*ExpertSubmitViewController *expertSVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ExpertSubmitViewController"];
    [self presentViewController:expertSVC animated:YES completion:nil];
     */
}

#pragma IndustrySelectDelegate
-(void)selectIndustry:(NSString *)industryName{
    BroadCastViewController * broadCastVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"BroadcasterSelectController"];
    [self.navigationController pushViewController:broadCastVC animated:YES];
}
@end
