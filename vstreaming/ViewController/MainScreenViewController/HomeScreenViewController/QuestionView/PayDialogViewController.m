//
//  PayDialogViewController.m
//  vstreaming
//
//  Created by developer on 10/11/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "PayDialogViewController.h"

@interface PayDialogViewController ()
@property (weak, nonatomic) IBOutlet UIView *popView;
@property (weak, nonatomic) IBOutlet UILabel *amountLbl;

@end

@implementation PayDialogViewController

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)closeBtnPressed:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClicked:)]) {
        [self.delegate cancelButtonClicked:self];
    }
}
- (IBAction)payBtnPressed:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClicked:)]) {
        [self.delegate payButtonClicked:self];
    }
}

-(void)initUI{
    dispatch_async(dispatch_get_main_queue(), ^{
      [self.amountLbl setText:self.amount];
    });
}

@end
