//
//  DetailViewController.h
//  vstreaming
//
//  Created by developer on 7/24/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GeneralConstant.h"

@interface DetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    SelectedTab selectedTab;
}
-(void) setSelectMarksHiddenQuests:(BOOL) qs Expert:(BOOL) ae SuggestQt:(BOOL) sq;
-(void) setScreenMode:(LiveStreamingScreenMode) mode;
-(void) switchCamera:(UITapGestureRecognizer *)recognizer;
@end


