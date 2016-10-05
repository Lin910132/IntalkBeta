//
//  Follower.m
//  vstreaming
//
//  Created by developer on 10/6/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "Follower.h"

@implementation Follower
+(id)parseDataFromJson:(NSDictionary *)dict{
    Follower *model = [Follower new];
    
    model.follow_id     = [dict objectForKey:@"id"];
    model.avatar_url    = [dict objectForKey:@"avatar_url"];
    model.sex           = [dict objectForKey:@"sex"];
    model.title         = [dict objectForKey:@"title"];
    model.descripText   = [dict objectForKey:@"description"];
    return model;
}
@end
