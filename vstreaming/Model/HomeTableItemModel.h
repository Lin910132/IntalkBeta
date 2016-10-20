//
//  HomeTableItemModel.h
//  vstreaming
//
//  Created by developer on 10/5/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeTableItemModel : NSObject
@property (atomic) int item_id;
@property (atomic) int user_id;
@property (nonatomic, retain) NSString* img_url;
@property (nonatomic, retain) NSString* rtmp_url;
@property (nonatomic, retain) NSString* video_url;
@property (nonatomic, retain) NSString* avatar_url;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* created_at;
@property (atomic) int viewCount;
@property (atomic) int tag1_id;
@property (atomic) int tag2_id;
@property (atomic) int tag3_id;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* descriptText;
@property (atomic) int likes;

+(id) parseDataFromJson:(NSDictionary *) dict;
@end
