//
//  VideoModel.h
//  vstreaming
//
//  Created by developer on 10/6/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoModel : NSObject
@property (nonatomic, retain) NSString * video_id;
@property (nonatomic, retain) NSString * title;
@property (atomic) int tag1_id;
@property (atomic) int tag2_id;
@property (atomic) int tag3_id;
@property (nonatomic, retain) NSString * descripText;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * created_at;

+(id) parseDataFromJson:(NSDictionary *) dict;
@end
