//
//  MyBalanceViewController.m
//  vstreaming
//
//  Created by developer on 7/26/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "MyBalanceViewController.h"
@interface MyBalanceViewController()
@property (weak, nonatomic) IBOutlet UIView *depositView3;
@property (weak, nonatomic) IBOutlet UIView *depositView2;
@property (weak, nonatomic) IBOutlet UIView *depositView1;
@end

@implementation MyBalanceViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self.depositView1.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.depositView2.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.depositView3.layer setBorderColor:[UIColor lightGrayColor].CGColor];
}

- (IBAction)backBtnClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
