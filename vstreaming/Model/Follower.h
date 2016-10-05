//
//  Follower.h
//  vstreaming
//
//  Created by developer on 10/6/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Follower : NSObject
@property (nonatomic, retain) NSString * follow_id;
@property (nonatomic, retain) NSString * avatar_url;
@property (nonatomic, retain) NSString * sex;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * descripText;

+(id) parseDataFromJson:(NSDictionary *) dict;
@end
