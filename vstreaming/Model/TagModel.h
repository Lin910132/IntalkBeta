//
//  TagModel.h
//  vstreaming
//
//  Created by developer on 9/30/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TagModel : NSObject
@property (atomic) int experts;
@property (atomic) int tag_id;
@property (nonatomic, retain) NSString* tagImg;
@property (nonatomic, retain) NSString* tagName;

+(id) parseDataFromJson:(NSDictionary *) dict;
@end
