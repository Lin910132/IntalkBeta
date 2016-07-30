//
//  IndustrySelectViewController.h
//  vstreaming
//
//  Created by developer on 7/24/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IndustrySelectDelegate
-(void)selectIndustry:(NSString *) industryName;
@end

@interface IndustrySelectViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain) id<IndustrySelectDelegate> delegate;
@end
