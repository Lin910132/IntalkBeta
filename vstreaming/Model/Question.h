//
//  Question.h
//  vstreaming
//
//  Created by developer on 10/11/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Question : NSObject
@property (nonatomic, retain) NSString * answer;
@property (nonatomic, retain) NSString * name;
@property (atomic) int broadcastID;
@property (atomic) int questionID;
@property (atomic) int diamond;
@property (nonatomic, retain) NSString * question;
@property (atomic) int user_id;
@property (atomic) BOOL isAnswered;

+(id) parseDataFromJson:(NSDictionary *) dict;
@end
