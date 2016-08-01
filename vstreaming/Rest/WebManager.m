//
//  WebManager.m
//  vstreaming
//
//  Created by developer on 7/31/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "WebManager.h"
#import "AFNetworking.h"
#import "APIConstant.h"

@implementation WebManager

+(void)GET:(NSString*)url  parameters:(id)parameters completion:(void (^)(NSDictionary* JSON, NSError* error)) completion {
    
    NSURL *baseUrl = [NSURL URLWithString:APIBaseURL];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithBaseURL:baseUrl];
    
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //NSLog(@"data: %@", responseObject);
        completion(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error: %@", error);
        completion(nil, error);
    }];
}

+(void)POST:(NSString*)url  parameters:(id)parameters completion:(void (^)(NSDictionary* JSON, NSError* error)) completion {
    NSURL *baseUrl = [NSURL URLWithString:APIBaseURL];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithBaseURL:baseUrl];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completion(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error: %@", error);
        completion(nil, error);
    }];
}

@end