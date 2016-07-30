//
//  QuestionViewController.m
//  vstreaming
//
//  Created by developer on 7/26/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "QuestionViewController.h"
@interface QuestionViewController()
@property (weak, nonatomic) IBOutlet UITextField *priceEdit;

@end
@implementation QuestionViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard {
    [self.priceEdit resignFirstResponder];
}

- (IBAction)backBtnClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
