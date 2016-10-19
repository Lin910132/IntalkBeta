//
//  LoginViewController.m
//  vstreaming
//
//  Created by developer on 7/23/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "LoginViewController.h"
#import "CountrySelectViewController.h"
#import "MainTabViewController.h"
#import "APIConstant.h"
#import "InTalkAPI.h"
#import "GeneralConstant.h"
#import "CommonFunction.h"
#import <DGActivityIndicatorView.h>
#import "Utility.h"
@interface LoginViewController ()<CountrySelectDelegate> {
    NSString *phonePrefix;
    NSString *codeId;
    
}
@property (weak, nonatomic) IBOutlet UILabel *countryCode;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeField;
@property (weak, nonatomic) IBOutlet UIButton *btnSendPhoneNum;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;

- (IBAction)onClickedCountryCode:(id)sender;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    // Do any additional setup after loading the view.
}

-(void) initUI{
    [_indicatorView setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backBtnPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) setLoadingStatus:(BOOL) isShow{
    if(isShow) {
        [_indicatorView startAnimating];
        _btnSendPhoneNum.userInteractionEnabled = NO;
        _btnLogin.userInteractionEnabled = NO;
        [_indicatorView setHidden:NO];
    }else{
        [_indicatorView stopAnimating];
        _btnSendPhoneNum.userInteractionEnabled = YES;
        _btnLogin.userInteractionEnabled = YES;
        [_indicatorView setHidden:YES];
    }
}

- (IBAction)phoneNumRequestBtnPressed:(id)sender {
    NSString *phoneNum = _phoneTextField.text;
    if(phonePrefix == nil){
        SHOWALLERT(@"Error", @"Please Select Country");
        return;
    }else if([CommonFunction isStringEmpty:phoneNum]){
        SHOWALLERT(@"Error", @"Please Input Phone number");
        return;
    }
    [self setLoadingStatus:YES];
    [InTalkAPI getCodeIDWithPhoneNum:phoneNum phoneNationCode:phonePrefix completion:^(NSDictionary *response, NSError *result){
        [self setLoadingStatus:NO];
        if(result == nil){
            codeId = [[NSString alloc]initWithFormat:@"%@",[response objectForKey:@"codeid"]];
        }else{
            SHOWALLERT(@"Error", @"Errow while login");
        }
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onClickedCountryCode:(id)sender {
    CountrySelectViewController *countrySelectView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CountrySelectViewController"];
    countrySelectView.delegate = self;
    [self.navigationController pushViewController:countrySelectView animated:YES];
}

- (IBAction)onClickedLogin:(id)sender {
    NSString *verifyCode = _verifyCodeField.text;
    
    if([CommonFunction isStringEmpty:verifyCode]){
        SHOWALLERT(@"Error", @"Please input Verify code");
        return;
    }
    
    if([CommonFunction isStringEmpty:codeId]){
        SHOWALLERT(@"Error", @"Please Verify Phone number");
        return;
    }
    
    [self setLoadingStatus:YES];
    [InTalkAPI loginWithCodeID:codeId verifyCode:verifyCode completion:^(NSDictionary *response, NSError *result){
        [self setLoadingStatus:NO];
        if(result == nil){
            NSString *token = [response objectForKey:@"token"];
            
            [[User getInstance] setUserToken:token];
            
            //add navigation feature
            MainTabViewController *mainTabViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MainTabBarController"];
            [self presentViewController:mainTabViewController animated:YES completion:nil];
        }else{
            SHOWALLERT(@"Error", @"Your inputed verify code is wrong");
        }
    }];
     
    
//    MainTabViewController *mainTabViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MainTabBarController"];
//    [self presentViewController:mainTabViewController animated:YES completion:nil];
    
}

#pragma arguments - Delegate of CountrySelectViewController
-(void)selectCountry:(NSString *)countryName phonePrefix:(NSString *)prefix{
    NSString *countryData = [NSString stringWithFormat:@"%@ (+%@)", countryName, prefix];
    phonePrefix = prefix;
    self.countryCode.text = countryData;
    self.countryCode.textColor = [UIColor grayColor];
}
@end
