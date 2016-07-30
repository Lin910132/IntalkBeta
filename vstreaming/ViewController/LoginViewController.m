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
@interface LoginViewController ()<CountrySelectDelegate>
@property (weak, nonatomic) IBOutlet UILabel *countryCode;

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
-(void)selectCountry:(NSString *)countryName{
    self.countryCode.text = countryName;
    self.countryCode.textColor = [UIColor blackColor];
}
@end
