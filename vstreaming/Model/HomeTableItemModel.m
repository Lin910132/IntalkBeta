//
//  HomeTableItemModel.m
//  vstreaming
//
//  Created by developer on 10/5/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "HomeTableItemModel.h"

@implementation HomeTableItemModel
+(id)parseDataFromJson:(NSDictionary *)dict{
    HomeTableItemModel *model = [HomeTableItemModel new];
    
    model.item_id           = [[dict objectForKey:@"id"] intValue];
    model.user_id           = [[dict objectForKey:@"user_id"] intValue];
    model.name              = [dict objectForKey:@"name"];
    model.title             = [dict objectForKey:@"title"];
    model.img_url           = [dict objectForKey:@"img_url"];
    model.avatar_url        = [dict objectForKey:@"avatar_url"];
    model.rtmp_url          = [dict objectForKey:@"url"];
    model.video_url         = [dict objectForKey:@"video_url"];
    model.tag1_id           = [[dict objectForKey:@"tag1_id"] intValue];
    model.tag2_id           = [[dict objectForKey:@"tag2_id"] intValue];
    model.tag3_id           = [[dict objectForKey:@"tag3_id"] intValue];
    model.viewCount         = [[dict objectForKey:@"views"] intValue];
    model.descriptText      = [dict objectForKey:@"description"];
    model.created_at        = [dict objectForKey:@"created_at"];
    model.likes             = [[dict objectForKey:@"like"]intValue];
    return model;
}

@end
