//
//  Utility.h
//  vstreaming
//
//  Created by developer on 8/8/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#ifndef Utility_h
#define Utility_h

#import <Foundation/Foundation.h>


@interface Utility : NSObject
+(void) saveDataWithKey:(NSString *) key Data:(NSObject *) data;
+(NSObject *) getDataWithKey:(NSString *) key;
@end

#endif /* Utility_h */
