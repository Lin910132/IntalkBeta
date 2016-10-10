//
//  User.m
//  vstreaming
//
//  Created by developer on 9/12/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "User.h"

static User * userInfo;
@implementation User
+(id) getInstance{
    if(!userInfo) {
        userInfo = [User new];
    }
    
    return userInfo;
}
#pragma mark - Private
-(NSString *) getUserToken{
    return (NSString *)[Utility getDataWithKey:TOKEN];
}

-(void)setUserToken:(NSString *)token{
    [Utility saveDataWithKey:TOKEN Data:token];
}

-(NSString *)getName{
    return self.name;
}

-(void)parseDataFromJson:(NSDictionary *)dict{
    self.avatar_url         = [dict objectForKey:@"avatar_url"];
    self.balance            = [[dict objectForKey:@"balance"] intValue];
    self.company            = [dict objectForKey:@"company"];
    self.descriptSentence   = [dict objectForKey:@"description"];
    self.email              = [dict objectForKey:@"email"];
    self.expert             = [[dict objectForKey:@"expert"] intValue];
    self.followers          = [[dict objectForKey:@"followers"] intValue];
    self.following          = [[dict objectForKey:@"following"] intValue];
    self.user_id            = [[dict objectForKey:@"id"] intValue];
    self.income             = [[dict objectForKey:@"income"] intValue];
    self.level              = [[dict objectForKey:@"level"] intValue];
    self.name               = [dict objectForKey:@"name"];
    self.other_id           = [dict objectForKey:@"other_id"];
    self.phonenumber        = [dict objectForKey:@"phonenumber"];
    self.sex                = [dict objectForKey:@"sex"];
    self.show               = [[dict objectForKey:@"show"] intValue];
    self.tag1_id            = [[dict objectForKey:@"tag1_id"] intValue];
    self.tag2_id            = [[dict objectForKey:@"tag2_id"] intValue];
    self.tag3_id            = [[dict objectForKey:@"tag3_id"] intValue];
    self.title              = [dict objectForKey:@"title"];
    self.years              = [[dict objectForKey:@"years"] intValue];
}

-(int) getExpert{
    return self.expert;
}
@end
