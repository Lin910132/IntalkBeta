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

@interface LoginViewController ()<CountrySelectDelegate>{
    NSString *phonePrefix;
    NSString *codeId;
}
@property (weak, nonatomic) IBOutlet UILabel *countryCode;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeField;

- (IBAction)onClickedCountryCode:(id)sender;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backBtnPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
    
    [InTalkAPI getCodeIDWithPhoneNum:phoneNum completion:^(NSDictionary *JSON, NSError *result){
        if(result == nil){
            codeId = [JSON objectForKey:@"codeid"];
        }else{
            SHOWALLERT(@"Error", @"Errow while login");
        }
    }];
}

- (IBAction)loginWithPhoneNumber:(id)sender {
    NSString *verifyCode = _verifyCodeField.text;
    
    if([CommonFunction isStringEmpty:verifyCode]){
        SHOWALLERT(@"Error", @"Please input Verify code");
    }
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
    MainTabViewController *mainTabViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MainTabBarController"];
    
    
    [self presentViewController:mainTabViewController animated:YES completion:nil];
}

#pragma arguments - Delegate of CountrySelectViewController
-(void)selectCountry:(NSString *)countryName phonePrefix:(NSString *)prefix{
    NSString *countryData = [NSString stringWithFormat:@"%@ (+%@)", countryName, prefix];
    phonePrefix = prefix;
    self.countryCode.text = countryData;
    self.countryCode.textColor = [UIColor grayColor];
}
@end
