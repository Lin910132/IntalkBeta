//
//  CommonFunction.m
//  vstreaming
//
//  Created by developer on 8/1/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonFunction.h"
@implementation CommonFunction

+ (BOOL)isStringEmpty:(NSString *)string {
    if([string length] == 0) { //string is empty or nil
        return YES;
    }
    
    if(![[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]) {
        //string is all whitespace
        return YES;
    }
    
    return NO;
}

+(BOOL) isArrayEmpty:(NSArray *)array{
    if( array == nil || [array count] == 0) {
        return YES;
    }
    return NO;
}
@end