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


+(void)startBroadcastWithToken:(NSString *) token Url:(NSString *) urlStr completion:(void(^)(NSDictionary * json, NSError *error)) block{
    NSDictionary *params = @{@"token":token, @"url":urlStr};
    [WebManager POST:APIStartBroadCast parameters:params completion:block];
}

+(void)stopBroadCasting:(NSString *)token Video:(NSString *)base64Video block:(void (^)(NSDictionary *, NSError *))block{
    NSDictionary *params = @{@"token":token,
                             @"video":base64Video};
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

+(void)setExpert:(NSString *)token Name:(NSString *)name Company:(NSString *)company Title:(NSString *)title Years:(int)year PhoneNumber:(NSString *)phone Email:(NSString *)email TagID1:(int)id1 TagID2:(int)id2 TagID3:(int)id3 Description:(NSString *)descript competion:(void (^)(NSDictionary *, NSError *))block{
    NSDictionary *params = @{
                             @"token"       : token,
                             @"name"        : name,
                             @"company"     : company,
                             @"title"       : title,
                             @"years"       : [NSString stringWithFormat:@"%d", year],
                             @"phonenumber" : phone,
                             @"email"       : email,
                             @"tagid1"      : [NSString stringWithFormat:@"%d", id1],
                             @"tagid2"      : [NSString stringWithFormat:@"%d", id2],
                             @"tagid3"      : [NSString stringWithFormat:@"%d", id3],
                             @"description" : descript
                            };
    [WebManager POST:APISetExpert parameters:params completion:block];
}

+(void)getLiveBroadcast:(NSString *)token limit:(int)limit offset:(int)offset competion:(void (^)(NSDictionary *, NSError *))block{
    NSDictionary *params = @{@"token"   :token,
                             @"limit"   :[NSString stringWithFormat:@"%d", limit],
                             @"offset"  :[NSString stringWithFormat:@"%d", offset],
                             };
    [WebManager POST:APIGetLiveBroadCast parameters:params completion:block];
}

+(void)getPreview:(NSString *)token limit:(int)limit offset:(int)offset competion:(void (^)(NSDictionary *, NSError *))block{
    NSDictionary *params = @{@"token"   :token,
                             @"limit"   :[NSString stringWithFormat:@"%d", limit],
                             @"offset"  :[NSString stringWithFormat:@"%d", offset],
                             };
    [WebManager POST:APIGetPreview parameters:params completion:block];
}

+(void)setAvatarImage:(NSString *)token imageData:(NSString *)base64Image competion:(void (^)(NSDictionary *, NSError *))block{
    NSDictionary *params = @{@"token"   :token,
                             @"img"     :base64Image
                             };
    [WebManager POST:APISetAvatar parameters:params completion:block];
}

+(void)getFollowers:(NSString *)token limit:(int)limit offset:(int)offset competion:(void (^)(NSDictionary *, NSError *))block{
    NSDictionary *params = @{@"token"   :token,
                             @"limit"   :[NSString stringWithFormat:@"%d", limit],
                             @"offset"  :[NSString stringWithFormat:@"%d", offset],
                             };
    [WebManager POST:APIGetFollowers parameters:params completion:block];
}

+(void)getFollowing:(NSString *)token limit:(int)limit offset:(int)offset competion:(void (^)(NSDictionary *, NSError *))block{
    NSDictionary *params = @{@"token"   :token,
                             @"limit"   :[NSString stringWithFormat:@"%d", limit],
                             @"offset"  :[NSString stringWithFormat:@"%d", offset],
                             };
    [WebManager POST:APIGetFollowing parameters:params completion:block];
}

+(void) getMessages:(NSString *)token userID:(NSString *)userId limit:(int)limit offset:(int)offset competion:(void (^)(NSDictionary *, NSError *))block{
    NSDictionary *params = @{@"token"   :token,
                             @"userid"  : userId,
                             @"limit"   :[NSString stringWithFormat:@"%d", limit],
                             @"offset"  :[NSString stringWithFormat:@"%d", offset],
                             };
    [WebManager POST:APIGetMessages parameters:params completion:block];
}

+(void)sendMessage:(NSString *)token userID:(NSString *)userId message:(NSString *)message competion:(void (^)(NSDictionary *, NSError *))block{
    NSDictionary *params = @{@"token"   :token,
                             @"userid"  : userId,
                             @"message"  : message
                             };
    [WebManager POST:APISendMessage parameters:params completion:block];
}
@end
