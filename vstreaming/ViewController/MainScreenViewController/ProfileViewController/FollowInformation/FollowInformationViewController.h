//
//  FollowInformationViewController.h
//  vstreaming
//
//  Created by developer on 7/27/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GeneralConstant.h"

@interface FollowInformationViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
-(void) setScreenType:(FollowScreenInfoType) type;
@end
