//
//  Expert.m
//  vstreaming
//
//  Created by developer on 10/14/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "Expert.h"

@implementation Expert
+(id)parseDataFromJson:(NSDictionary *)dict{
    Expert *model = [Expert new];
    
    model.avatar_url    = [dict objectForKey:@"avatar_url"];
    model.broadcast     = [dict objectForKey:@"broadcast"];
    model.company       = [dict objectForKey:@"company"];
    model.descriptionTxt= [dict objectForKey:@"description"];
    model.followers     = [[dict objectForKey:@"followers"] intValue];
    model.following     = [[dict objectForKey:@"following"] intValue];
    model.name          = [dict objectForKey:@"name"];
    model.sex           = [dict objectForKey:@"sex"];
    model.title         = [dict objectForKey:@"title"];
    return model;
}
@end
