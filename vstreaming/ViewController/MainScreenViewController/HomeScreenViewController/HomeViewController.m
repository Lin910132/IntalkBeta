//
//  HomeViewController.m
//  vstreaming
//
//  Created by developer on 7/23/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"
#import "DetailViewController.h"
#import "AKPickerView.h"
@interface HomeViewController () <AKPickerViewDataSource, AKPickerViewDelegate>
{
    NSMutableArray * tableData;
    NSArray *pickerList;
}
@property (weak, nonatomic) IBOutlet AKPickerView *pickerView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //init homeTableView
    [self initPickerView];
    [self loadLiveStream];
    self.homeTableView.separatorColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private functions
-(void) initPickerView{
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    pickerList = @[@"Recommended", @"New", @"Preview"];
    self.pickerView.font = [UIFont systemFontOfSize:12];
    self.pickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.pickerView.textColor = [UIColor whiteColor];
    self.pickerView.highlightedTextColor = [UIColor whiteColor];
    self.pickerView.highlightedFont = [UIFont systemFontOfSize:14];
    self.pickerView.interitemSpacing = 20.0;
    self.pickerView.fisheyeFactor = 0.001;
    self.pickerView.pickerViewStyle = AKPickerViewStyle3D;
    self.pickerView.maskDisabled = false;
    [self.pickerView reloadData];
    [self.pickerView selectItem:1 animated:NO]; //Select New Tab
}

-(void) loadLiveStream{
    [InTalkAPI getLiveBroadcast:[[User getInstance]getUserToken] limit:10 offset:0 competion:^(NSDictionary *json, NSError *err) {
        if(!err){
            NSLog(@"%@", json);
        }else{
            NSLog(@"\n --- Get Live Broadcast API occurs such error %@", err);
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

#pragma mark - TableView Delegates
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1; //because there is no sections
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * homeTableItemIdentifier = @"HomeTableViewCell";
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:homeTableItemIdentifier];
    if(cell == nil){
        cell = [[HomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:homeTableItemIdentifier];
        
    }
    NSMutableDictionary *itemData; //TODO set real data to item Data
    [cell setDataToCell:itemData];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detailVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DetailViewController"];
    [detailVC setScreenMode:Streaming_Client];
    [self presentViewController:detailVC animated:YES completion:nil];
}

#pragma AKPickerView data Source 
- (NSUInteger)numberOfItemsInPickerView:(AKPickerView *)pickerView{
    return [pickerList count];
}

- (NSString *)pickerView:(AKPickerView *)pickerView titleForItem:(NSInteger)item{
    return pickerList[item];
}

#pragma AKPickerView delegate
- (void)pickerView:(AKPickerView *)pickerView didSelectItem:(NSInteger)item{
    
}

@end
