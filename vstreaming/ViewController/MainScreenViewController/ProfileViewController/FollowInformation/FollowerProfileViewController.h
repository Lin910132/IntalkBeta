//
//  FollowerProfileViewController.h
//  vstreaming
//
//  Created by developer on 7/27/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GeneralConstant.h"
@interface FollowerProfileViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    SelectedTabOnProfile selectedTab;
}
@property (nonatomic, retain) User *profile;
@end
