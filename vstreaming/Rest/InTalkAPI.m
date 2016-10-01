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

+(void)getCodeIDWithPhoneNum:(NSString *)phoneNum phoneNationCode:(NSString *)nationCode completion:(void (^)(NSDictionary *, NSError *))block{
    NSDictionary *params = @{@"phonenumber":phoneNum, @"nationcode":nationCode};
    [WebManager POST:APIRequestUserWithPhone parameters:params completion:block];
}

+(void)loginWithCodeID:(NSString *)codeID verifyCode:(NSString *)verifyCode completion:(void (^)(NSDictionary *, NSError *))block{
    NSDictionary *params = @{@"codeid":codeID, @"code":verifyCode};
    [WebManager POST:APILoginWithPhone parameters:params completion:block];
}


+(void)startBroadcastWithTitle:(NSString *)title Url:(NSString *)urlStr Tag1:(NSString *)tag1 Tag2:(NSString *)tag2 Tag3:(NSString *)tag3 completion:(void (^)(NSDictionary *, NSError *))block{
    NSString *token = (NSString *)[Utility getDataWithKey:TOKEN];
    NSDictionary *params = @{@"token":token, @"tagid1":tag1, @"tagid2":tag2, @"tag3":tag3, @"title":title, @"url":urlStr};
    [WebManager POST:APIStartBroadCast parameters:params completion:block];
}

+(void)stopBroadCasting:(void (^)(NSDictionary *, NSError *))block{
    NSString *token = (NSString *)[Utility getDataWithKey:TOKEN];
    NSDictionary *params = @{@"token":token};
    [WebManager POST:APIEndBroadCast parameters:params completion:block];
}

+(void)loginWithThirdPartySDK:(NSString *) sdkPrefix Token:(NSString *) token completion:(void(^)(NSDictionary * json, NSError *error)) block{
    NSString * otherID = [NSString stringWithFormat:@"%@%@", sdkPrefix, token];
    NSDictionary *params = @{@"otherid":otherID};
    [WebManager POST:APILoginWithOther parameters:params completion:block];
}

+(void)getAllTags:(NSString *)token competion:(void (^)(NSDictionary *, NSError *))block{
    NSDictionary *params = @{@"token":token};
    [WebManager POST:APIGetTags parameters:params completion:block];
}

+(void)searchTagsWithToken:(NSString *)token limit:(int)limit offset:(int)offset key:(NSString *) key competion:(void (^)(NSDictionary *, NSError *))block{
    NSDictionary *params = @{@"token"   :token,
                             @"limit"   :[NSString stringWithFormat:@"%d", limit],
                             @"offset"  :[NSString stringWithFormat:@"%d", offset],
                             @"key"     :key
                             };
    [WebManager POST:APISearchTags parameters:params completion:block];
}

+(void)getMyInfoByToken:(NSString *)token competion:(void (^)(NSDictionary *, NSError *))block{
    NSDictionary *params = @{@"token"   :token};
    [WebManager POST:APIGetMyInfo parameters:params completion:block];
}

@end
