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
#import "WebManager.h"
#import <Crashlytics/Crashlytics.h>

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
//    UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    button.frame = CGRectMake(20, 50, 100, 30);
//    [button setTitle:@"Crash" forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(crashButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];

}

//- (IBAction)crashButtonTapped:(id)sender {
//    [[Crashlytics sharedInstance] crash];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)callWeChatLogIn:(id)sender {
    if ([WechatAccess isWechatAppInstalled]) {
        [[WechatAccess defaultAccess] login:^(BOOL succeeded, id object) {
            if(succeeded) {
                NSString *openId = [(NSDictionary *)object valueForKey:@"openid"];
                NSString *headimgurl = [(NSDictionary *)object valueForKey:@"headimgurl"];
                [(AppDelegate *)[[UIApplication sharedApplication] delegate] showLoaderWithString:@"Log in..."];
                [InTalkAPI loginWithThirdPartySDK:@"wechat" Token:openId profileUrl:headimgurl completion:^(NSDictionary *response, NSError *err){
                    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hideLoader];
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
            NSString *profile = [(NSDictionary *)object valueForKey:@"figureurl_qq_2"];
            NSLog(@"%@", object);
            [(AppDelegate *)[[UIApplication sharedApplication] delegate] showLoaderWithString:@"Log in..."];
            [InTalkAPI loginWithThirdPartySDK:@"qq" Token:openId profileUrl:profile completion:^(NSDictionary *response, NSError *err){
                [(AppDelegate *)[[UIApplication sharedApplication] delegate] hideLoader];
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
            NSDictionary *userInfo = [object objectForKey:@"userInfo"];
            NSString* accessToken = [userInfo objectForKey:@"access_token"];
            
            NSDictionary*param = @{@"access_token"   :accessToken,
                                   @"uid"   : openId};
            [(AppDelegate *)[[UIApplication sharedApplication] delegate] showLoaderWithString:@"Log in..."];
            [WebManager GET:@"https://api.weibo.com/2/users/show.json" parameters:param completion:^(NSDictionary *JSON, NSError *error) {
                if(!error){
                    //NSDictionary *data = [JSON objectForKey:@"data"];
                    NSString *profile = [JSON objectForKey:@"avatar_large"];
                    [InTalkAPI loginWithThirdPartySDK:@"weibo" Token:openId profileUrl:profile completion:^(NSDictionary *response, NSError *err){
                        [(AppDelegate *)[[UIApplication sharedApplication] delegate] hideLoader];
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
                    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hideLoader];
                    SHOWALLERT(@"Error", @"Error occured while login wechat");
                }
            }];
        }else{
            SHOWALLERT(@"Error", @"Error occured while login wechat");
        }
    }];
}


@end
