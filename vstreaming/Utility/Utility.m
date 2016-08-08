//
//  Utility.m
//  vstreaming
//
//  Created by developer on 8/8/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "Utility.h"

@interface Utility()

@end

@implementation Utility

+(void)saveDataWithKey:(NSString *)key Data:(NSObject *)data{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:data forKey:key];
    [defaults synchronize];
}

+(NSObject *)getDataWithKey:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSObject * data = [defaults objectForKey:key];
    return data;
}
@end
