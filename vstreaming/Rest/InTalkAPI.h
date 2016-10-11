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
+(void) stopBroadCasting:(NSString*) token broadcastID:(int) broadcastID Video:(NSString *) base64Video block:(void(^)(NSDictionary * json, NSError *error)) block;

//tagks
+(void) getAllTags:(NSString *) token competion:(void(^)(NSDictionary * json, NSError *error)) block;
+(void) searchTagsWithToken:(NSString *)token limit:(int)limit offset:(int)offset key:(NSString*) key competion:(void (^)(NSDictionary *, NSError *))block;

//profile info
+(void) getMyInfoByToken:(NSString *)token competion:(void (^)(NSDictionary *, NSError *))block;
+(void) setAvatarImage:(NSString *)token imageData:(NSString *) base64Image competion:(void (^)(NSDictionary *, NSError *))block;
+(void) getFollowers:(NSString *)token limit:(int)limit offset:(int)offset competion:(void (^)(NSDictionary *, NSError *))block;
+(void) getFollowing:(NSString *)token limit:(int)limit offset:(int)offset competion:(void (^)(NSDictionary *, NSError *))block;
//expert
+(void) setExpert:(NSString *)token Name:(NSString*) name Company:(NSString *) company Title:(NSString *) title Years:(int) year PhoneNumber:(NSString*) phone Email:(NSString*) email TagID1:(int) id1 TagID2:(int) id2 TagID3:(int) id3 Description:(NSString *) descript competion:(void (^)(NSDictionary *, NSError *))block;

+(void) searchExpert:(NSString *)token tagID:(int)tagID limit:(int)limit offset:(int)offset competion:(void (^)(NSDictionary *, NSError *))block;

+(void) getExpert:(NSString *)token userID:(int) userID competion:(void (^)(NSDictionary *, NSError *))block;
//show streaming
+(void) getLiveBroadcast:(NSString *)token limit:(int)limit offset:(int)offset competion:(void (^)(NSDictionary *, NSError *))block;
+(void) getPreview:(NSString *)token limit:(int)limit offset:(int)offset competion:(void (^)(NSDictionary *, NSError *))block;
+(void) getRecord:(NSString *)token limit:(int)limit offset:(int)offset competion:(void (^)(NSDictionary *, NSError *))block;
//message
+(void) getMessages:(NSString *)token userID:(NSString*) userId limit:(int)limit offset:(int)offset competion:(void (^)(NSDictionary *, NSError *))block;

+(void) sendMessage:(NSString *)token userID:(NSString*) userId message:(NSString*) message competion:(void (^)(NSDictionary *, NSError *))block;

+(void) getMessageUsers:(NSString *)token limit:(int)limit offset:(int)offset competion:(void (^)(NSDictionary *resp, NSError *err))block;

//question and answer
+(void) addQuestion:(NSString *)token broadcastId:(int) broadcastID message:(NSString*) message diamond:(NSString*)diamond competion:(void (^)(NSDictionary *, NSError *))block;

+(void) getQuestions:(NSString *)token broadcastId:(int) broadcastID competion:(void (^)(NSDictionary *, NSError *))block;

+(void) getAllQuestions:(NSString *)token broadcastId:(int) broadcastID competion:(void (^)(NSDictionary *, NSError *))block;

+(void) addAnswer:(NSString *)token questionId:(int) questionId answer:(NSString*) answer competion:(void (^)(NSDictionary *, NSError *))block;

@end
