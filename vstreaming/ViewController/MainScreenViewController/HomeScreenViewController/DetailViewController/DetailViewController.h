//
//  DetailViewController.h
//  vstreaming
//
//  Created by developer on 7/24/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GeneralConstant.h"
#import "HomeTableItemModel.h"
#import "QuestionTableCellForFullScreen.h"
@interface DetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    SelectedTab selectedTab;
}

@property (nonatomic, retain) NSString * liveStreamName;
@property (nonatomic, retain) NSString * recoredVideoUrl;
@property (nonatomic, retain) NSString * liveStreamTitle;
//@property (atomic) int broadcastID;
//@property (atomic) int userID;
@property (nonatomic, retain) HomeTableItemModel * info;

-(void) setSelectMarksHiddenQuests:(BOOL) qs Expert:(BOOL) ae SuggestQt:(BOOL) sq;
-(void) setScreenMode:(LiveStreamingScreenMode) mode;
@end


