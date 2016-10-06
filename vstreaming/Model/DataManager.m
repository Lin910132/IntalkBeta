//
//  DataManager.m
//  vstreaming
//
//  Created by developer on 9/30/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "DataManager.h"
#import "TagModel.h"
static DataManager * dataManager;
@implementation DataManager

#pragma mark - static functions
+(id)getInstance{
    if(!dataManager){
        dataManager = [DataManager new];
    }
    return dataManager;
}

#pragma mark - public functions

-(NSMutableArray *)getAllTags{
    return self.allTags;
}

-(NSString*) findTagByID:(int)tagID{
    NSString *tagName = @"Unknown";
    for(TagModel *tag in self.allTags){
        if(tag.tag_id == tagID){
            tagName = tag.tagName;
        }
    }
    
    return tagName;
}
@end
