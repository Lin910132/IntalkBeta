//
//  InTalkAPI.h
//  vstreaming
//
//  Created by developer on 7/31/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface InTalkAPI : NSObject
+(void) getCodeIDWithPhoneNum:(NSString *) phoneNum
                 completion:(void(^)(NSDictionary * json, NSError *error)) block;

+(void) loginWithCodeID:(NSString *) codeID verifyCode:(NSString *) verifyCode
                completion:(void(^)(NSDictionary * json, NSError *error)) block;
@end
