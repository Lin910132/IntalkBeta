//
//  TagModel.m
//  vstreaming
//
//  Created by developer on 9/30/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "TagModel.h"

@implementation TagModel

+(id)parseDataFromJson:(NSDictionary *)dict{
    TagModel *model = [TagModel new];
    
    model.experts   = [[dict objectForKey:@"experts"]intValue];
    model.tag_id    = [[dict objectForKey:@"id"]intValue];
    model.tagImg    = [dict objectForKey:@"img_url"];
    model.tagName   = [dict objectForKey:@"name"];
    
    return model;
}
@end
