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
@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *token = (NSString *)[Utility getDataWithKey:TOKEN];
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
//            [_textField setText:[NSString stringWithFormat:@"%@",object]];
        }];
    } else {
//        [_textField setText:@"Wechat not installed!"];
    }

}

- (IBAction)callQQLogIn:(id)sender {
//    if ([TencentAccess isTencentAppInstalled]) {
//        [[TencentAccess defaultAccess] login:^(BOOL succeeded, id object) {
//            NSLog(@"%@",object);
//            //        [_textView setText:[NSString stringWithFormat:@"%@",object]];
//        }];
//    }
    [[TencentAccess defaultAccess] login:^(BOOL succeeded, id object) {
        NSLog(@"%@",object);
        //        [_textView setText:[NSString stringWithFormat:@"%@",object]];
    }];
}

- (IBAction)callWeiboLogIn:(id)sender {
    [[WeiboAccess defaultAccess] login:^(BOOL succeeded, id object) {
        if (succeeded) {
//            [_textView setText:[NSString stringWithFormat:@"%@",object]];
        }else{
            if (WeiboStatusCodeAuthDeny == [object[WEIBO_STATUS_CODE] integerValue]) {
//                [_textView setText:@"sso package or sign error"];
            }
        }
    }];
}


@end
