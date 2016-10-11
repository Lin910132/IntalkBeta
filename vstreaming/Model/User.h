//
//  User.h
//  vstreaming
//
//  Created by developer on 9/12/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, retain) NSString * avatar_url;
@property (atomic) int balance;
@property (nonatomic, retain) NSString * company;
@property (nonatomic, retain) NSString * descriptSentence;
@property (nonatomic, retain) NSString * email;
@property (atomic) int expert;
@property (atomic) int followers;
@property (atomic) int following;
@property (atomic) int user_id;
@property (atomic) int income;
@property (atomic) int level;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * other_id;
@property (nonatomic, retain) NSString * phonenumber;
@property (nonatomic, retain) NSString * sex;
@property (atomic) int show;
@property (atomic) int tag1_id;
@property (atomic) int tag2_id;
@property (atomic) int tag3_id;
@property (nonatomic, retain) NSString * title;
@property (atomic) int years;

+(id) getInstance;

-(NSString *) getUserToken;
-(NSString *) getName;
-(int) getUserID;
-(void) setUserToken:(NSString *) token;
-(void) parseDataFromJson:(NSDictionary *) dict;
-(int) getExpert;
@end
