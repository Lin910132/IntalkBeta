//
//  WechatAccess.h
//  Wechat-OAuth
//
//  Created by developer on 16/8/9.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <UIKit/UIImage.h>

@interface WechatAccess : NSObject

+ (WechatAccess *)defaultAccess;;

+ (BOOL)registerApp;

+ (BOOL)handleOpenURL:(NSURL *)url;

+ (BOOL)isWechatAppInstalled;

- (void)login:(void(^)(BOOL succeeded, id object))result;

- (void)shareWithWebviewInTimeLineOrNot:(BOOL)inOrNot
                                pageUrl:(NSString *)pageUrl
                                  title:(NSString *)title
                            description:(NSString *)description
                                  image:(UIImage *)image
                             completion:(void(^)(BOOL succeeded, id object))shareResult;

@end
