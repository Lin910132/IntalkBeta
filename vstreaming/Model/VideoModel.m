//
//  VideoModel.m
//  vstreaming
//
//  Created by developer on 10/6/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "VideoModel.h"

@implementation VideoModel
+(id)parseDataFromJson:(NSDictionary *)dict{
    VideoModel *model = [VideoModel new];
    
    model.video_id     = [dict objectForKey:@"id"];
    model.title         = [dict objectForKey:@"title"];
    model.tag1_id            = [[dict objectForKey:@"tag1_id"] intValue];
    model.tag2_id            = [[dict objectForKey:@"tag2_id"] intValue];
    model.tag3_id            = [[dict objectForKey:@"tag3_id"] intValue];
    model.url    = [dict objectForKey:@"url"];    
    model.descripText   = [dict objectForKey:@"description"];
    model.created_at   = [dict objectForKey:@"created_at"];
    return model;
}
@end
