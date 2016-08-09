//
//  GeneralConstant.h
//  vstreaming
//
//  Created by developer on 7/24/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#ifndef GeneralConstant_h
#define GeneralConstant_h

typedef NS_ENUM(NSInteger, SelectedTab)
{
    QuestionTabSelected = 0,
    ExpertTabSelected,
    SuggestQTTabSelected
};

typedef NS_ENUM(NSInteger, SelectedTabOnProfile)
{
    ProfileExpertTabSelected = 0,
    ShowTabSelected
};

typedef NS_ENUM(NSInteger, SelectedSetting)
{
    Privacy_Policy = 0,
    Rules_Info,
    Terms_Service
};

typedef NS_ENUM(NSInteger, FollowScreenInfoType)
{
    Follower_Screen = 0,
    Following_Screen
};

typedef NS_ENUM(NSInteger, ExpertSearchTapType)
{
    Expert_Tab = 0,
    Tag_Tab
};

#define greenColorForButtons [UIColor colorWithRed:0.3 green:0.57 blue:0.43 alpha:1]

#define SHOWALLERT(title, mes) UIAlertController *controller = \
[UIAlertController alertControllerWithTitle:title \
message:mes \
preferredStyle:UIAlertControllerStyleAlert];\
UIAlertAction *cancelAction = \
[UIAlertAction actionWithTitle:@"OK" \
style:UIAlertActionStyleCancel \
handler:nil];\
[controller addAction:cancelAction];\
[self presentViewController:controller \
animated:YES \
completion:nil];\
controller.view.tintColor = \
greenColorForButtons


#define TOKEN @"token"

//QCloud live active broadcasting identifier
#define kSdkAppId       @"1400001692"
#define kSdkAccountType @"884"
#define kIdentifier @"884"


#endif /* GeneralConstant_h */
