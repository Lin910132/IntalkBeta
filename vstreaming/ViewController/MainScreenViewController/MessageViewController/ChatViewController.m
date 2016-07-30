//
//  ChatViewController.m
//  vstreaming
//
//  Created by developer on 7/28/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "ChatViewController.h"
#import <UITextView+Placeholder.h>
#import <DAKeyboardControl.h>
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
    
    __weak typeof(self) weakSelf = self;
    [self.view addKeyboardPanningWithFrameBasedActionHandler:nil constraintBasedActionHandler:^(CGRect keyboardFrameInView, BOOL opening, BOOL closing){
        static CGFloat y;
        
        if (opening || y == 0)
        {
            y = keyboardFrameInView.origin.y + keyboardFrameInView.size.height;
        }
        if (closing){
            weakSelf.bottomViewHeightConstraint.constant = 40.0f;
            weakSelf.bottomSpaceForBottomView.constant = 0;
            [weakSelf.view layoutIfNeeded];
        }else {
            weakSelf.bottomViewHeightConstraint.constant = 40.0f;
            weakSelf.bottomSpaceForBottomView.constant = y - keyboardFrameInView.origin.y; // 50 is the tab height
        }
    }];
}
@end
