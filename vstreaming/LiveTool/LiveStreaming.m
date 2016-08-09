//
//  LiveStreaming.m
//  vstreaming
//
//  Created by developer on 8/8/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LiveStreaming.h"

@interface LiveStreaming(){
    QAVContext *av_context;
    TIMManager *imm_manager;
}

@end

@implementation LiveStreaming

+(LiveStreaming *)sharedInstance{
    static dispatch_once_t predicate = 0;
    __strong static id sharedObject = nil;
    dispatch_once(&predicate, ^{
        sharedObject = [[self alloc] init];
        [sharedObject initQAVContext];
    });
    return sharedObject;
}

-(void) initQAVContext{
    QAVContextConfig* config = [[QAVContextConfig alloc]init];
    config.sdk_app_id       = kSdkAppId;
    config.app_id_at3rd     = kSdkAppId;
    config.account_type     = kSdkAccountType;
    config.identifier       = kIdentifier;
    av_context = [QAVContext CreateContext:config];
}

-(QAVContext *)getQAVContextInstance{
    return av_context;
}

-(void) destroyContext{
    if(av_context){
        [QAVContext DestroyContext:av_context];
        av_context = nil;
    }
}

-(TIMManager *)getTIMManager{
    return imm_manager;
}

-(void)initTIMManager{
    [[TIMManager sharedInstance]setEnv:0];
    [[TIMManager sharedInstance]initSdk: [kSdkAppId intValue]];
}
@end