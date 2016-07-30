//
//  MyShowViewController.m
//  vstreaming
//
//  Created by developer on 7/25/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "MyShowViewController.h"
#import <RCRunkeeperSwitch.h>
@interface MyShowViewController()
@property (weak, nonatomic) IBOutlet RCRunkeeperSwitch *btnSwitch;

@end

@implementation MyShowViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initSwitch];
}

- (IBAction)backBtnPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) initSwitch{
    _btnSwitch.leftTitle = @"New";
    _btnSwitch.rightTitle = @"Hot";
    _btnSwitch.backgroundColor = [UIColor whiteColor];
    _btnSwitch.layer.borderColor = [UIColor lightGrayColor].CGColor ;
    _btnSwitch.layer.borderWidth = 0.6;
    _btnSwitch.layer.cornerRadius = 12.0;
    _btnSwitch.layer.masksToBounds = YES;
    _btnSwitch.selectedBackgroundColor = [UIColor colorWithRed:53.0/255.0 green:147.0/255.0 blue:221.0/255.0 alpha:1.0];
    _btnSwitch.titleColor = [UIColor lightGrayColor];
    _btnSwitch.selectedTitleColor = [UIColor whiteColor];
    _btnSwitch.selectedBackgroundInset = 0.0;
    _btnSwitch.titleFont = [UIFont systemFontOfSize:10];
    //_btnSwitch.frame = CGRectMake(50, 20, CGRectGetWidth(self.view.bounds) - 100, 30);
}

@end
