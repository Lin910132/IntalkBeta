//
//  ChatViewController.m
//  vstreaming
//
//  Created by developer on 7/28/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "ChatViewController.h"
#import <UITextView+Placeholder.h>
//#import <DAKeyboardControl.h>
@interface ChatViewController()
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UITextView *messageField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpaceForBottomView;

@end

@implementation ChatViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.messageField.placeholder = @"Type here...";
    self.messageField.returnKeyType = UIReturnKeyDone;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard {
    [self.view endEditing:YES];
}

- (IBAction)backBtnClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sendMessage:(id)sender {
    if([_messageField.text isEqualToString:@""]){
        
    }else{
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] showLoaderWithString:@"Sending"];
        NSString *userID = [NSString stringWithFormat:@"%d", [[User getInstance]getUserID]];
        [InTalkAPI sendMessage:[[User getInstance]getUserToken] userID:userID message:_messageField.text competion:^(NSDictionary *resp, NSError *err) {
            [(AppDelegate *)[[UIApplication sharedApplication] delegate] hideLoader];
        }];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    
}
@end
