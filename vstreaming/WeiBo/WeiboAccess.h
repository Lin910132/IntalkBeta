//
//  WeiboAccess.h
//  Weibo-OAuth
//
//  Created by developer on 8/11/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

#define WEIBO_STATUS_CODE @"status_code"

extern NSInteger const WeiboStatusCodeAuthDeny;

@interface WeiboAccess : NSObject

+ (WeiboAccess *)defaultAccess;;

+ (void)enableDebugMode:(BOOL)enabled;

+ (BOOL)registerApp;

+ (BOOL)handleOpenURL:(NSURL *)url;

- (void)login:(void(^)(BOOL succeeded, id object))result;

@end
