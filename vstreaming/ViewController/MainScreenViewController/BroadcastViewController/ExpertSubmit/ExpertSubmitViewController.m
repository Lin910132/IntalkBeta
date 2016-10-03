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
}
@property (weak, nonatomic) IBOutlet UIButton *years3;
@property (weak, nonatomic) IBOutlet UIButton *years5_10;
@property (weak, nonatomic) IBOutlet UIButton *years3_5;
@property (weak, nonatomic) IBOutlet UIButton *years10More;
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
    DataManager * data = [DataManager getInstance];
    arryList = [NSMutableArray new];
    for(TagModel *item in data.allTags){
        [arryList addObject:item.tagName];
    }
    [self setSelectedBtnFirst:YES Second:NO Third:NO Forth:NO];
}

#pragma mark - outlets
- (IBAction)btn0_3yearClicked:(id)sender {
    [self setSelectedBtnFirst:YES Second:NO Third:NO Forth:NO];
}
- (IBAction)btn3_5Clicked:(id)sender {
    [self setSelectedBtnFirst:NO Second:YES Third:NO Forth:NO];
}
- (IBAction)btn5_10Clicked:(id)sender {
    [self setSelectedBtnFirst:NO Second:NO Third:YES Forth:NO];
}
- (IBAction)btn5MoreClicked:(id)sender {
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

#pragma mark - kDropDownListViewDelegate
- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex{
    /*----------------Get Selected Value[Single selection]-----------------*/
    //_lblSelectedCountryNames.text=[arryList objectAtIndex:anIndex];
}
- (void)DropDownListView:(DropDownListView *)dropdownListView Datalist:(NSMutableArray*)ArryData{
    
    /*----------------Get Selected Value[Multiple selection]-----------------*/
    /*if (ArryData.count>0) {
        _lblSelectedCountryNames.text=[ArryData componentsJoinedByString:@"\n"];
        CGSize size=[self GetHeightDyanamic:_lblSelectedCountryNames];
        _lblSelectedCountryNames.frame=CGRectMake(16, 240, 287, size.height);
    }
    else{
        _lblSelectedCountryNames.text=@"";
    }*/
    
}
- (void)DropDownListViewDidCancel{
    
}

@end
