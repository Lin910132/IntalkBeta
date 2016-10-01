//
//  DataManager.m
//  vstreaming
//
//  Created by developer on 9/30/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "DataManager.h"

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

@end
