//
//  OtherSettingViewController.m
//  vstreaming
//
//  Created by developer on 7/28/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "OtherSettingViewController.h"

@interface OtherSettingViewController(){
        SelectedSetting selectedSetting;
}

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UITextView *txtprivacy;
@property (weak, nonatomic) IBOutlet UIImageView *imgRues;
@property (weak, nonatomic) IBOutlet UITextView *txtTerms;


@end
@implementation OtherSettingViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
}

-(void)setSelectedTab:(SelectedSetting) tab{
    selectedSetting = tab;
}
-(void) initUI {
    if(selectedSetting == Privacy_Policy ){
        _lblTitle.text = @"Privacy Policy";
        [self.txtprivacy setHidden:NO];
        [self.imgRues setHidden:YES];
        [self.txtTerms setHidden:YES];
        
        
    }else if(selectedSetting == Rules_Info){
        _lblTitle.text = @"Rules & Info";
        [self.txtprivacy setHidden:YES];
        [self.imgRues setHidden:NO];
        [self.txtTerms setHidden:YES];
        
    }else {
        _lblTitle.text = @"Terms of Service";
        [self.txtprivacy setHidden:YES];
        [self.imgRues setHidden:YES];
        [self.txtTerms setHidden:NO];
    }
}
    
- (IBAction)backBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
