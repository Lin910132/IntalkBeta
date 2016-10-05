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

-(void)viewWillAppear:(BOOL)animated{
    
}
@end
