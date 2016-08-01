//
//  WebManager.h
//  vstreaming
//
//  Created by developer on 7/31/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#ifndef WebManager_h
#define WebManager_h

#import <Foundation/Foundation.h>

@interface WebManager : NSObject

+(void)GET:(NSString*)url parameters:(id)parameters completion:(void (^)(NSDictionary* JSON, NSError* error)) completion;
+(void)POST:(NSString*)url parameters:(id)parameters completion:(void (^)(NSDictionary* JSON, NSError* error)) completion;

@end


#endif /* WebManager_h */
