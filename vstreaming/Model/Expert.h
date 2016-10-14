//
//  Expert.h
//  vstreaming
//
//  Created by developer on 10/14/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Expert : NSObject
@property (nonatomic, retain) NSString * avatar_url;
@property (nonatomic, retain) NSString * broadcast;
@property (nonatomic, retain) NSString * company;
@property (nonatomic, retain) NSString * descriptionTxt;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * sex;
@property (nonatomic, retain) NSString * title;
@property (atomic) int followers;
@property (atomic) int following;
+(id) parseDataFromJson:(NSDictionary *) dict;

@end
