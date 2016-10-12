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

+(void)stopBroadCasting:(NSString*) token broadcastID:(int) broadcastID Video:(NSString *) base64Video block:(void(^)(NSDictionary * json, NSError *error)) block{
    NSDictionary *params;
    if(base64Video){
        params = @{@"token"       :token,
                   @"broadcastid" :[NSString stringWithFormat:@"%d",broadcastID],
                   @"video"       :base64Video};
    }else{
        params = @{@"token"       :token,
                   @"broadcastid" :[NSString stringWithFormat:@"%d",broadcastID]};
    }
    
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

+(void)getRecord:(NSString *)token limit:(int)limit offset:(int)offset competion:(void (^)(NSDictionary *, NSError *))block{
    NSDictionary *params = @{@"token"   :token,
                             @"limit"   :[NSString stringWithFormat:@"%d", limit],
                             @"offset"  :[NSString stringWithFormat:@"%d", offset],
                             };
    [WebManager POST:APIGetRecord parameters:params completion:block];
}

+(void)searchExpert:(NSString *)token tagID:(int)tagID limit:(int)limit offset:(int)offset competion:(void (^)(NSDictionary *, NSError *))block{
    NSDictionary *params = @{@"token"   :token,
                             @"tagid"   :[NSString stringWithFormat:@"%d", tagID],
                             @"limit"   :[NSString stringWithFormat:@"%d", limit],
                             @"offset"  :[NSString stringWithFormat:@"%d", offset],
                             };
    
    [WebManager POST:APISearchExpert parameters:params completion:block];
}

+(void)addQuestion:(NSString *)token broadcastId:(int)broadcastID message:(NSString *)message diamond:(NSString *)diamond competion:(void (^)(NSDictionary *, NSError *))block{
    NSDictionary *params = @{@"token"       :token,
                             @"broadcastid" :[NSString stringWithFormat:@"%d", broadcastID],
                             @"question"    : message,
                             @"diamond"     :diamond
                             };
    
    [WebManager POST:APIAddQuestion parameters:params completion:block];
}

+(void)getQuestions:(NSString *)token broadcastId:(int)broadcastID competion:(void (^)(NSDictionary *, NSError *))block{
    NSDictionary *params = @{@"token"       :token,
                             @"broadcastid" :[NSString stringWithFormat:@"%d", broadcastID]
                             };
    
    [WebManager POST:APIGetQuestions parameters:params completion:block];
}

+(void)getAllQuestions:(NSString *)token broadcastId:(int)broadcastID competion:(void (^)(NSDictionary *, NSError *))block{
    NSDictionary *params = @{@"token"       :token,
                             @"broadcastid" :[NSString stringWithFormat:@"%d", broadcastID]
                             };
    
    [WebManager POST:APIGetAllQuestions parameters:params completion:block];
}

+(void)addAnswer:(NSString *)token questionId:(int)questionId answer:(NSString *)answer competion:(void (^)(NSDictionary *resp, NSError * err))block{
    NSDictionary *params = @{@"token"       :token,
                             @"questionId"  :[NSString stringWithFormat:@"%d", questionId],
                             @"answer"      :answer
                             };
    [WebManager POST:APIAddAnswer parameters:params completion:block];
}

+(void)getMessageUsers:(NSString *)token limit:(int)limit offset:(int)offset competion:(void (^)(NSDictionary *, NSError *))block{
    NSDictionary *params = @{@"token"   :token,
                             @"limit"   :[NSString stringWithFormat:@"%d", limit],
                             @"offset"  :[NSString stringWithFormat:@"%d", offset]
                             };
    [WebManager POST:APIGetMessageUsers parameters:params completion:block];
}

+(void)getExpert:(NSString *)token userID:(int)userID competion:(void (^)(NSDictionary *resp, NSError *err))block{
    NSDictionary *params = @{@"token"   :token,
                             @"userid"   :[NSString stringWithFormat:@"%d", userID]
                             };
    [WebManager POST:APIGetExpert parameters:params completion:block];
}


+(void)follow:(NSString *)token userID:(int)userid competion:(void (^)(NSDictionary *, NSError *))block{
    NSDictionary *params = @{@"token"   :token,
                             @"userid"   :[NSString stringWithFormat:@"%d", userid]
                             };
    [WebManager POST:APIFollow parameters:params completion:block];
}

+(void)getVideos:(NSString *)token userID:(int)userid competion:(void (^)(NSDictionary *, NSError *))block{
    NSDictionary *params = @{@"token"   :token,
                             @"userid"   :[NSString stringWithFormat:@"%d", userid]
                             };
    [WebManager POST:APIGetVideos parameters:params completion:block];
}
@end
