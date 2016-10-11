//
//  PayDialogViewController.h
//  vstreaming
//
//  Created by developer on 10/11/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PayDialogPopupDelegate;

@interface PayDialogViewController : UIViewController
@property (assign, nonatomic) id <PayDialogPopupDelegate>delegate;
@property (nonatomic, retain) NSString * amount;

-(void) initUI;
@end

@protocol PayDialogPopupDelegate<NSObject>
@optional
- (void)cancelButtonClicked:(PayDialogViewController*)secondDetailViewController;
- (void)payButtonClicked:(PayDialogViewController*)secondDetailViewController;
@end