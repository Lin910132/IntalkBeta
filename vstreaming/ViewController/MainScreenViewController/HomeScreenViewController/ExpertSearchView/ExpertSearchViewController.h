//
//  ExpertSearchScreen.h
//  vstreaming
//
//  Created by developer on 7/29/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpertSearchViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *expertSearchTable;

@property (nonatomic) NSInteger tagID;
@end
