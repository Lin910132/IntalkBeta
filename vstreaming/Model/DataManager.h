//
//  DataManager.h
//  vstreaming
//
//  Created by developer on 9/30/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

@property (nonatomic, retain) NSMutableArray *allTags;

+(id) getInstance;
-(NSMutableArray *) getAllTags;
@end
