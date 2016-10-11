//
//  QuestionViewController.h
//  vstreaming
//
//  Created by developer on 7/26/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *questionTxt;
@property (weak, nonatomic) IBOutlet UITextField *diamondAmount;
@property (atomic) int broadcastId;
@end
