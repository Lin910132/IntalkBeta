//
//  InTalkAPI.m
//  vstreaming
//
//  Created by developer on 7/31/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "InTalkAPI.h"
#import "APIConstant.h"
#import <AFNetworking.h>
#import "WebManager.h"
@interface InTalkAPI()

@end

@implementation InTalkAPI

+(void)getCodeIDWithPhoneNum:(NSString *)phoneNum completion:(void (^)(NSDictionary *, NSError *))block{
    NSDictionary *params = @{@"phonenumber":phoneNum};
    [WebManager POST:APIRequestUserWithPhone parameters:params completion:block];
}

+(void)loginWithCodeID:(NSString *)codeID verifyCode:(NSString *)verifyCode completion:(void (^)(NSDictionary *, NSError *))block{
    NSDictionary *params = @{@"codeid":codeID, @"code":verifyCode};
    [WebManager POST:APILoginWithPhone parameters:params completion:block];
}


@end
