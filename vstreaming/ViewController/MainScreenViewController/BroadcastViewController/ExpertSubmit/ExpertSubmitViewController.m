//
//  ExperSubmitViewController.m
//  vstreaming
//
//  Created by developer on 7/25/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "ExpertSubmitViewController.h"
#import "DropDownListView.h"
#import "TagModel.h"

@interface ExpertSubmitViewController () <kDropDownListViewDelegate>
{
    NSMutableArray * arryList;
    DropDownListView * Dropobj;
    NSMutableArray * selectedTagIDs;
    DataManager * dataManager;
    int selectedYear;
    int tag_id1, tag_id2, tag_id3;
}
@property (weak, nonatomic) IBOutlet UIButton *years3;
@property (weak, nonatomic) IBOutlet UIButton *years5_10;
@property (weak, nonatomic) IBOutlet UIButton *years3_5;
@property (weak, nonatomic) IBOutlet UIButton *years10More;
@property (weak, nonatomic) IBOutlet UITextField *tagTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *companyTextField;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;


@end


@implementation ExpertSubmitViewController
#pragma mark - private
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

-(void)showPopUpWithTitle:(NSString*)popupTitle withOption:(NSArray*)arrOptions xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple{
    
    
    Dropobj = [[DropDownListView alloc] initWithTitle:popupTitle options:arrOptions xy:point size:size isMultiple:isMultiple];
    Dropobj.delegate = self;
    [Dropobj showInView:self.view animated:YES];
    
    /*----------------Set DropDown backGroundColor-----------------*/
    [Dropobj SetBackGroundDropDown_R:0.0 G:108.0 B:194.0 alpha:0.70];
    
}

#pragma mark - parent functions
-(void)viewWillAppear:(BOOL)animated{
    [self setStatusBarBackgroundColor:UIColorFromRGB(0x3593DD)];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    dataManager = [DataManager getInstance];
    arryList = [NSMutableArray new];
    selectedTagIDs = [NSMutableArray new];
    selectedYear = Year0_3;
    
    self.tagTextField.userInteractionEnabled = NO;
    for(TagModel *item in dataManager.allTags){
        [arryList addObject:item.tagName];
    }
    [self setSelectedBtnFirst:YES Second:NO Third:NO Forth:NO];
}

#pragma mark - outlets
- (IBAction)btn0_3yearClicked:(id)sender {
    selectedYear = Year0_3;
    [self setSelectedBtnFirst:YES Second:NO Third:NO Forth:NO];
}
- (IBAction)btn3_5Clicked:(id)sender {
    selectedYear = Year3_5;
    [self setSelectedBtnFirst:NO Second:YES Third:NO Forth:NO];
}
- (IBAction)btn5_10Clicked:(id)sender {
    selectedYear = Year5_10;
    [self setSelectedBtnFirst:NO Second:NO Third:YES Forth:NO];
}
- (IBAction)btn5MoreClicked:(id)sender {
    selectedYear = Year10_;
    [self setSelectedBtnFirst:NO Second:NO Third:NO Forth:YES];
}

-(void) setSelectedBtnFirst:(BOOL) first Second:(BOOL) secnd Third:(BOOL) third Forth:(BOOL) forth{
    [self.years3.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.years3_5.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.years5_10.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.years10More.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
    self.years3.backgroundColor = [UIColor whiteColor];
    self.years3_5.backgroundColor = [UIColor whiteColor];
    self.years5_10.backgroundColor = [UIColor whiteColor];
    self.years10More.backgroundColor = [UIColor whiteColor];
    [self.years3 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.years3_5 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.years5_10 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.years10More setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    if(first == YES){
        self.years3.backgroundColor = [UIColor colorWithRed:53.0/255.0 green:147.0/255.0 blue:221.0/255.0 alpha:1.0];
        [self.years3.layer setBorderColor:[UIColor colorWithRed:53.0/255.0 green:147.0/255.0 blue:221.0/255.0 alpha:1.0].CGColor];
        [self.years3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else if(secnd == YES){
        self.years3_5.backgroundColor = [UIColor colorWithRed:53.0/255.0 green:147.0/255.0 blue:221.0/255.0 alpha:1.0];
        [self.years3_5.layer setBorderColor:[UIColor colorWithRed:53.0/255.0 green:147.0/255.0 blue:221.0/255.0 alpha:1.0].CGColor];
        [self.years3_5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else if(third == YES){
        self.years5_10.backgroundColor = [UIColor colorWithRed:53.0/255.0 green:147.0/255.0 blue:221.0/255.0 alpha:1.0];
        [self.years5_10.layer setBorderColor:[UIColor colorWithRed:53.0/255.0 green:147.0/255.0 blue:221.0/255.0 alpha:1.0].CGColor];
        [self.years5_10 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        self.years10More.backgroundColor = [UIColor colorWithRed:53.0/255.0 green:147.0/255.0 blue:221.0/255.0 alpha:1.0];
        [self.years10More.layer setBorderColor:[UIColor colorWithRed:53.0/255.0 green:147.0/255.0 blue:221.0/255.0 alpha:1.0].CGColor];
        [self.years10More setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

- (IBAction)backBtnClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)tagBtnPressed:(id)sender {
    [Dropobj fadeOut];
    [self showPopUpWithTitle:@"Select Tags" withOption:arryList xy:CGPointMake(16, 58) size:CGSizeMake(287, 330) isMultiple:YES];

}
- (IBAction)submitBtnPressed:(id)sender {
    if(!self.nameTextField.text){
        SHOWALLERT(@"Error", @"Please Input Name");
        return;
    }
    
    if(!self.companyTextField.text){
        SHOWALLERT(@"Error", @"Please Input Company");
        return;
    }
    
    if(!self.titleTextField.text){
        SHOWALLERT(@"Error", @"Please Input Title");
        return;
    }
    
    if(!self.phoneTextField.text){
        SHOWALLERT(@"Error", @"Please Input Phone number");
        return;
    }
    
    if(!self.emailTextField.text){
        SHOWALLERT(@"Error", @"Please Input Email number");
        return;
    }
    
    if(!self.tagTextField.text){
        SHOWALLERT(@"Error", @"Please Select Tag items");
        return;
    }
    
    if(!self.tagTextField.text){
        SHOWALLERT(@"Error", @"Please Input Description");
        return;
    }
    
    if([selectedTagIDs count] > 0){
        tag_id1 = [[selectedTagIDs objectAtIndex:0] intValue];
    }
    
    if([selectedTagIDs count] > 1){
        tag_id1 = [[selectedTagIDs objectAtIndex:0] intValue];
    }
    
    if([selectedTagIDs count] > 2){
        tag_id1 = [[selectedTagIDs objectAtIndex:0] intValue];
    }
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] showLoaderWithString:@"Sending..."];
    
    [InTalkAPI setExpert:[[User getInstance]getUserToken]  Name:_nameTextField.text Company:_companyTextField.text Title:_titleTextField.text Years:selectedYear PhoneNumber:_phoneTextField.text Email:_emailTextField.text TagID1:tag_id1 TagID2:tag_id2 TagID3:tag_id3 Description:_descriptionTextField.text
               competion:^(NSDictionary *json, NSError * err) {
                   [(AppDelegate *)[[UIApplication sharedApplication] delegate] hideLoader];
                   if(!err){
                       [self backBtnClicked:nil];
                   }else{
                       NSLog(@"\nSet Expert API occured such err : %@", err);
                   }
    }];
}

#pragma mark - kDropDownListViewDelegate
- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex{
    /*----------------Get Selected Value[Single selection]-----------------*/
    //_lblSelectedCountryNames.text=[arryList objectAtIndex:anIndex];
}
- (void)DropDownListView:(DropDownListView *)dropdownListView Datalist:(NSMutableArray*)arryData{
    
}
-(void)DropDownListView:(DropDownListView *)dropdownListView Datalist:(NSMutableArray *)arryData DataIndex:(NSMutableArray *)arrayIndex{
    self.tagTextField.text = @"";
    if (arryData.count > 0) {
        self.tagTextField.text = [arryData componentsJoinedByString:@", "];
        //arrayData size and arayIndex size is same
        for(NSIndexPath *item in arrayIndex){
            TagModel *selectedTag = [dataManager.getAllTags objectAtIndex:item.row];
            [selectedTagIDs addObject:[NSNumber numberWithInt:selectedTag.tag_id]];
        }
    }
}
- (void)DropDownListViewDidCancel{
    
}

@end
