//
//  InTalkAPI.h
//  vstreaming
//
//  Created by developer on 7/31/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface InTalkAPI : NSObject
+(void) getCodeIDWithPhoneNum:(NSString *) phoneNum phoneNationCode:(NSString *) nationCode
                 completion:(void(^)(NSDictionary * json, NSError *error)) block;

+(void) loginWithCodeID:(NSString *) codeID verifyCode:(NSString *) verifyCode
                completion:(void(^)(NSDictionary * json, NSError *error)) block;
+(void) startBroadcastWithTitle:(NSString *) title Url:(NSString *) urlStr Tag1:(NSString *) tag1 Tag2:(NSString *) tag2 Tag3:(NSString *) tag3 completion:(void(^)(NSDictionary * json, NSError *error)) block;

+(void) stopBroadCasting:(void(^)(NSDictionary * json, NSError *error)) block;

@end
