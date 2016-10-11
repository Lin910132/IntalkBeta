//
//  Question.m
//  vstreaming
//
//  Created by developer on 10/11/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "Question.h"

@implementation Question

+(id)parseDataFromJson:(NSDictionary *)dict{
    Question *model = [Question new];
    
    model.answer            = [dict objectForKey:@"answer"];
    model.question          = [dict objectForKey:@"question"];
    model.broadcastID       = [[dict objectForKey:@"broadcast_id"] intValue];
    model.diamond           = [[dict objectForKey:@"diamond"] intValue];
    model.questionID        = [[dict objectForKey:@"id"] intValue];
    model.user_id           = [[dict objectForKey:@"user_id"] intValue];
    
    return model;
}
@end
