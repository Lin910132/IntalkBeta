//
//  InTalkAPI.h
//  vstreaming
//
//  Created by developer on 7/31/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface InTalkAPI : NSObject

//login part
+(void) getCodeIDWithPhoneNum:(NSString *) phoneNum phoneNationCode:(NSString *) nationCode
                 completion:(void(^)(NSDictionary * json, NSError *error)) block;

+(void) loginWithCodeID:(NSString *) codeID verifyCode:(NSString *) verifyCode
                completion:(void(^)(NSDictionary * json, NSError *error)) block;
+(void) loginWithThirdPartySDK:(NSString *) sdkPrefix Token:(NSString *) token completion:(void(^)(NSDictionary * json, NSError *error)) block;

//broadcasting
+(void) startBroadcastWithToken:(NSString *) token Url:(NSString *) urlStr completion:(void(^)(NSDictionary * json, NSError *error)) block;
+(void) stopBroadCasting:(NSString*) token Video:(NSString *) base64Video block:(void(^)(NSDictionary * json, NSError *error)) block;

//tagks
+(void) getAllTags:(NSString *) token competion:(void(^)(NSDictionary * json, NSError *error)) block;
+(void) searchTagsWithToken:(NSString *)token limit:(int)limit offset:(int)offset key:(NSString*) key competion:(void (^)(NSDictionary *, NSError *))block;

//profile info
+(void) getMyInfoByToken:(NSString *)token competion:(void (^)(NSDictionary *, NSError *))block;

//expert
+(void) setExpert:(NSString *)token Name:(NSString*) name Company:(NSString *) company Title:(NSString *) title Years:(int) year PhoneNumber:(NSString*) phone Email:(NSString*) email TagID1:(int) id1 TagID2:(int) id2 TagID3:(int) id3 Description:(NSString *) descript competion:(void (^)(NSDictionary *, NSError *))block;

//show streaming
+(void) getLiveBroadcast:(NSString *)token limit:(int)limit offset:(int)offset competion:(void (^)(NSDictionary *, NSError *))block;
@end
