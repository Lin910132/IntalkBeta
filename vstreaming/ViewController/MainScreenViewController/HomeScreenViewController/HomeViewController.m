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
#import "HomeTableItemModel.h"
#import "ExpertSearchViewController.h"
@interface HomeViewController () <AKPickerViewDataSource, AKPickerViewDelegate, HomeTableViewCellDelegate>
{
    NSMutableArray * tableData;
    NSArray *pickerList;
    UIRefreshControl *refreshControl;
}
@property (weak, nonatomic) IBOutlet AKPickerView *pickerView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //init homeTableView
    tableData = [[NSMutableArray alloc] init];
    [self initPickerView];
    [self makeTableViewRefreshable];
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
    pickerList = @[@"Preview", @"Live", @"Record"];
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

-(void) loadPreview{
    [InTalkAPI getPreview:[[User getInstance]getUserToken] limit:100 offset:0 competion:^(NSDictionary *json, NSError * err) {
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] hideLoader];
        [refreshControl endRefreshing];
        
        if(!err){
            [tableData removeAllObjects];
            for(NSDictionary * item in [json objectForKey:@"data"]){
                HomeTableItemModel *cell = [HomeTableItemModel parseDataFromJson:item];
                [tableData addObject:cell];
            }
            
            [_homeTableView reloadData];
        }else{
            SHOWALLERT(@"Request error", err.localizedDescription);
        }
    }];
}

-(void) loadLiveInfo{
    [InTalkAPI getLiveBroadcast:[[User getInstance]getUserToken] limit:100 offset:0 competion:^(NSDictionary *json, NSError * err) {
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] hideLoader];
        [refreshControl endRefreshing];
        if(!err){
            [tableData removeAllObjects];
            for(NSDictionary * item in [json objectForKey:@"data"]){
                HomeTableItemModel *cell = [HomeTableItemModel parseDataFromJson:item];
                [tableData addObject:cell];
            }
            
            [_homeTableView reloadData];
        }else{
            SHOWALLERT(@"Request error", err.localizedDescription);
        }
    }];
}

-(void) loadRecordInfo{
    [InTalkAPI getRecord:[[User getInstance]getUserToken] limit:100 offset:0 competion:^(NSDictionary *json, NSError * err) {
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] hideLoader];
        [refreshControl endRefreshing];
        if(!err){
            [tableData removeAllObjects];
            for(NSDictionary * item in [json objectForKey:@"data"]){
                HomeTableItemModel *cell = [HomeTableItemModel parseDataFromJson:item];
                [tableData addObject:cell];
            }
            
            [_homeTableView reloadData];
        }else{
            SHOWALLERT(@"Request error", err.localizedDescription);
        }
    }];
}

-(void) makeTableViewRefreshable{
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    [self.homeTableView addSubview:refreshControl];
}

-(void) refreshTableView{
    [self pickerView:nil didSelectItem:self.pickerView.selectedItem];
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
    return [tableData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * homeTableItemIdentifier = @"HomeTableViewCell";
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:homeTableItemIdentifier];
    if(cell == nil){
        cell = [[HomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:homeTableItemIdentifier];
        
    }
    [cell initUI];
    cell.delegate = self;
    [cell setDataToCell:[tableData objectAtIndex:indexPath.row] cellType:self.pickerView.selectedItem];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detailVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DetailViewController"];
    
    HomeTableItemModel *itemData = [tableData objectAtIndex:indexPath.row];
    
    if(self.pickerView.selectedItem == RecordCell){
        detailVC.liveStreamName = itemData.video_url;
        detailVC.liveStreamName = @"rtmp://10.70.5.1:1935/vod/mp4:myStream.mp4";
        [detailVC setScreenMode:Streaming_Record];
    }else {
        [detailVC setScreenMode:Streaming_Client];
        detailVC.liveStreamName = itemData.rtmp_url;
    }
    //detailVC.broadcastID    = itemData.item_id;
    //detailVC.userID         = itemData.user_id;
    detailVC.info = itemData;
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
    
    if(pickerView){ //whenn refresh by swipe, this function is also called, but pickerView variable is nil
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] showLoaderWithString:@"Loading..."];
    }
    
    switch (item) {
        case 0:
            [self loadPreview];
            break;
        case 1:
            [self loadLiveInfo];
            break;
        case 2:
            [self loadRecordInfo];
            break;
        default:
            break;
    }
}

#pragma mark - HomeTableViewCellDelegate
-(void)didSelectTagButton:(NSInteger)tagID{
    ExpertSearchViewController *expertSearchVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ExpertSearchViewController"];
    
    expertSearchVC.tagID = tagID;
    [self presentViewController:expertSearchVC animated:YES completion:nil];
}

-(void)didShareButtonPressed:(NSString *)rtmp_url{
    NSString *shareText = @"This is my Vide URL";
    NSURL *shareURL = [NSURL URLWithString:rtmp_url];
    NSArray *itemsToShare = @[shareText, shareURL];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
    [self presentViewController:activityVC animated:YES completion:nil];
}
@end
