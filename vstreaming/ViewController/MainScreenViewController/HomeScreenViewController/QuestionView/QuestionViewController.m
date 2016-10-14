//
//  QuestionViewController.m
//  vstreaming
//
//  Created by developer on 7/26/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "QuestionViewController.h"
#import "PayDialogViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import <UITextView+Placeholder.h>
@interface QuestionViewController() <PayDialogPopupDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *priceEdit;

@end
@implementation QuestionViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
//                                   initWithTarget:self
//                                   action:@selector(dismissKeyboard)];
//    
//    [self.view addGestureRecognizer:tap];
    self.questionTxt.placeholder = @"Type here Question...";
    self.diamondAmount.delegate = self;
    
}

-(void)dismissKeyboard {
    [self.priceEdit resignFirstResponder];
}

#pragma mark - outlets
- (IBAction)backBtnClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnSendPressed:(id)sender {
    //[self showAnimate];
    PayDialogViewController *payDlg = [[PayDialogViewController alloc] initWithNibName:@"PayDialog" bundle:nil];
    payDlg.amount = self.priceEdit.text;
    payDlg.delegate = self;
    [payDlg initUI];
    [self presentPopupViewController:payDlg animationType:MJPopupViewAnimationFade];
}

#pragma mark - PayDialogPopupDelegate
-(void)cancelButtonClicked:(PayDialogViewController *)secondDetailViewController{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}
-(void)payButtonClicked:(PayDialogViewController *)secondDetailViewController{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] showLoaderWithString:@"Sending"];

    [InTalkAPI addQuestion:[[User getInstance] getUserToken] broadcastId:self.broadcastId message:self.questionTxt.text diamond:self.diamondAmount.text competion:^(NSDictionary *resp, NSError *err) {
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] hideLoader];
        if(!err){
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            SHOWALLERT(@"Sending error", err.localizedDescription);
        }
    }];
}

#pragma mark UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self.diamondLbl setText:textField.text];
}
@end
