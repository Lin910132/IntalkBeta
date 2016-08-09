//
//  LiveStreaming.h
//  vstreaming
//
//  Created by developer on 8/8/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#ifndef LiveStreaming_h
#define LiveStreaming_h
#import <Foundation/Foundation.h>
#import <QAVSDK/QAVContext.h>
#import "GeneralConstant.h"
#import <ImSDK/ImSDK.h>
#import <TLSSDK/TLSHelper.h>

@interface LiveStreaming : NSObject
+(LiveStreaming *) sharedInstance;
-(void) initQAVContext;
-(void) initTIMManager;
-(QAVContext *) getQAVContextInstance;
-(TIMManager *) getTIMManager;
@end
#endif /* LiveStreaming_h */
