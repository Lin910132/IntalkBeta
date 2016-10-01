//
//  ViewController.m
//  vstreaming
//
//  Created by developer on 7/22/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "SignUpViewController.h"
#import "WechatAccess.h"
#import "TencentAccess.h"
#import "WeiboAccess.h"
#import "MainTabViewController.h"
#import "InTalkAPI.h"
#import "User.h"
@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString * token = [[User getInstance] getUserToken];
    if(token){
        MainTabViewController *mainTabViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MainTabBarController"];
        [self presentViewController:mainTabViewController animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)callWeChatLogIn:(id)sender {
    if ([WechatAccess isWechatAppInstalled]) {
        [[WechatAccess defaultAccess] login:^(BOOL succeeded, id object) {
            if(succeeded) {
                NSString *openId = [(NSDictionary *)object valueForKey:@"openid"];
                [InTalkAPI loginWithThirdPartySDK:@"wechat" Token:openId completion:^(NSDictionary *response, NSError *err){
                    if(err == nil) {
                        NSString *token = [response objectForKey:@"token"];
                        //[Utility saveDataWithKey:TOKEN Data:token];
                        [[User getInstance] setUserToken:token];
                        //add navigation feature
                        
                        MainTabViewController *mainTabViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MainTabBarController"];
                        [self presentViewController:mainTabViewController animated:YES completion:nil];
                    }
                }];
            }else{
                SHOWALLERT(@"Error", @"Error occured while login wechat");
            }
        }];
    } else {
        SHOWALLERT(@"Warning", @"You need to install WeChat App");
    }

}

- (IBAction)callQQLogIn:(id)sender {
    [[TencentAccess defaultAccess] login:^(BOOL succeeded, id object) {
        if(succeeded) {
            
            NSString *openId = [(NSDictionary *)object valueForKey:@"open_id"];
            [InTalkAPI loginWithThirdPartySDK:@"qq" Token:openId completion:^(NSDictionary *response, NSError *err){
                if(err == nil) {
                    NSString *token = [response objectForKey:@"token"];
                    //[Utility saveDataWithKey:TOKEN Data:token];
                    [[User getInstance] setUserToken:token];
                    //add navigation feature
                    
                    MainTabViewController *mainTabViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MainTabBarController"];
                    [self presentViewController:mainTabViewController animated:YES completion:nil];
                }
            }];
        }else{
            SHOWALLERT(@"Error", @"Error occured while login wechat");
        }
        
    }];
}

- (IBAction)callWeiboLogIn:(id)sender {
    [[WeiboAccess defaultAccess] login:^(BOOL succeeded, id object) {
        if(succeeded) {
            NSString *openId = [(NSDictionary *)object valueForKey:@"userID"];
            [InTalkAPI loginWithThirdPartySDK:@"weibo" Token:openId completion:^(NSDictionary *response, NSError *err){
                if(err == nil) {
                    NSString *token = [response objectForKey:@"token"];
                    //[Utility saveDataWithKey:TOKEN Data:token];
                    [[User getInstance] setUserToken:token];
                    //add navigation feature
                    
                    MainTabViewController *mainTabViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MainTabBarController"];
                    [self presentViewController:mainTabViewController animated:YES completion:nil];
                }
            }];
        }else{
            SHOWALLERT(@"Error", @"Error occured while login wechat");
        }
    }];
}


@end
