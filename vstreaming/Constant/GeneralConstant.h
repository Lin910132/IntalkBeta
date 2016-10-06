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


typedef NS_ENUM(NSInteger, LiveStreamingScreenMode)
{
    Streaming_Host = 0,
    Streaming_Client
};


typedef NS_ENUM(NSInteger, ExpertLevel)
{
    Non_Expert = 0,
    Expert_Level_1
};

typedef NS_ENUM(NSInteger, YearValue)
{
    Year0_3 = 0,
    Year3_5 = 3,
    Year5_10= 5,
    Year10_ = 10
};

typedef NS_ENUM(NSInteger, HomeTableViewCellType)
{
    RecordCell = 0,
    LiveStramCell,
    PreviewCell
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

#define statusBarColor [UIColor colorWithRed:53.0/255 green:147.0/255 blue:221.0/255 alpha:1]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define TOKEN @"token"

#define RTMP_SERVER_ADDRESS     @"rtmp://www.intalk.tv:1935/live"
//#define RTMP_SERVER_ADDRESS     @"rtmp://10.70.5.1:1935/live"

//#define PLAY_LIST_URL           @"rtmp://10.70.5.1:1935/live/myStream"
//#define PLAY_LIST_URL           @"rtmp://www.intalk.tv:1935/live/myStream"




#endif /* GeneralConstant_h */
