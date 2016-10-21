//
//  ExpertSearchScreen.m
//  vstreaming
//
//  Created by developer on 7/29/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "ExpertSearchViewController.h"
#import "ExpertSearchTableCell.h"
#import "DetailViewController.h"
#import "GeneralConstant.h"
#import "FollowerProfileViewController.h"
@interface ExpertSearchViewController() <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>{
    ExpertSearchTapType selectedTab;
    NSMutableArray *tableDataforExpert;
    NSMutableArray *tableDataforShow;
    NSString *keyString;
    UIRefreshControl *refreshControl;
}
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet UIView *expertSelected;
@property (weak, nonatomic) IBOutlet UIView *tagSelected;
@property (weak, nonatomic) IBOutlet UIButton *expertBtn;
@property (weak, nonatomic) IBOutlet UIButton *tagBtn;

@end


@implementation ExpertSearchViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [_tagSelected setHidden:YES];
    selectedTab = Expert_Tab;
    [self.searchBar setImage:[UIImage imageNamed: @"icon_search.png"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    self.searchBar.delegate = self;
    tableDataforExpert = [NSMutableArray new];
    tableDataforShow   = [NSMutableArray new];
    [self makeTableViewRefreshable];
    //[self.expertBtn setTitle:[[User getInstance] getName] forState:UIControlStateNormal];
    //[self loadExpertData];
}

-(void) makeTableViewRefreshable{
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];
    [self.expertSearchTable addSubview:refreshControl];
}
#pragma mark - Private
-(void) loadData{
    if(selectedTab == Expert_Tab){
        [InTalkAPI searchExpertByKey:[[User getInstance]getUserToken] key:keyString limit:100 offset:0 competion:^(NSDictionary *resp, NSError *err) {
            [(AppDelegate *)[[UIApplication sharedApplication] delegate] hideLoader];
            [refreshControl endRefreshing];
            if(!err){
                [tableDataforExpert removeAllObjects];
                for(NSDictionary *item in [resp objectForKey:@"data"]){
                    User *expertUser = [User new];
                    [expertUser parseDataFromJson:item];
                    [tableDataforExpert addObject:expertUser];
                }
                
                [_expertSearchTable reloadData];
                
            }else{
                NSLog(@"Error----");
            }
        }];
    }else{
        [InTalkAPI searchBroadcastByKey:[[User getInstance]getUserToken] key:keyString limit:100 offset:0 competion:^(NSDictionary *resp, NSError *err) {
            [(AppDelegate *)[[UIApplication sharedApplication] delegate] hideLoader];
            [refreshControl endRefreshing];
            if(!err){
                [tableDataforShow removeAllObjects];
                for(NSDictionary * item in [resp objectForKey:@"data"]){
                    HomeTableItemModel *cell = [HomeTableItemModel parseDataFromJson:item];
                    [tableDataforShow addObject:cell];
                }
                
                [_expertSearchTable reloadData];
            }else{
                NSLog(@"Error----");
            }
        }];
    }
}

- (IBAction)backBtnClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)expertBtnClicked:(id)sender {
    selectedTab = Expert_Tab;
    [_expertSelected setHidden:NO];
    [_tagSelected setHidden:YES];
    [self.expertSearchTable reloadData];
}
- (IBAction)tagBtnClicked:(id)sender {
    selectedTab = Tag_Tab;
    [_expertSelected setHidden:YES];
    [_tagSelected setHidden:NO];
    [self.expertSearchTable reloadData];
}

#pragma TableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(selectedTab == Expert_Tab)
        return [tableDataforExpert count];
    else
        return [tableDataforShow count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        ExpertSearchTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExpertSearchTableCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(selectedTab == Expert_Tab)
        [cell initCell:[tableDataforExpert objectAtIndex:indexPath.row] selectedTab:selectedTab];
    else
        [cell initCell:[tableDataforShow objectAtIndex:indexPath.row] selectedTab:selectedTab];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(selectedTab == Expert_Tab){
        FollowerProfileViewController *followerProfileVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"FollowerProfileViewController"];
        followerProfileVC.profile = [tableDataforExpert objectAtIndex:indexPath.row];
        [self presentViewController:followerProfileVC animated:YES completion:nil];
    }
}

#pragma mark - UISearchBar
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] showLoaderWithString:@"Loading..."];
    keyString = searchBar.text;
    [self loadData];
    [[self view] endEditing:YES];
}
@end
