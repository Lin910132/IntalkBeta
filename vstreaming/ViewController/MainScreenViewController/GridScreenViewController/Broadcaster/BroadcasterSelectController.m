//
//  BroadcasterSelectController.m
//  vstreaming
//
//  Created by developer on 7/25/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "BroadcasterSelectController.h"
#import "BroadcasterTableCell.h"
#import "DetailViewController.h"
@interface BroadcasterSelectController()<UISearchBarDelegate>
{
    NSMutableArray * tableData;
    UIRefreshControl *refreshControl;
}
@property (weak, nonatomic) IBOutlet UITableView *broadcasterTable;

@end
@implementation BroadcasterSelectController
-(void)viewDidLoad{
    [super viewDidLoad];
    [self.searchBar setImage:[UIImage imageNamed: @"icon_search.png"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    self.searchBar.delegate = self;
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] showLoaderWithString:@"Loading..."];
    [self loadExpertData];
}
- (IBAction)backBtnClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) makeTableViewRefreshable{
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(loadExpertData) forControlEvents:UIControlEventValueChanged];
    [self.broadcasterTable addSubview:refreshControl];
}

-(void) loadExpertData{
    [InTalkAPI searchExpertByTagID:[[User getInstance]getUserToken] tagID:self.tag_id limit:100 offset:0 competion:^(NSDictionary *resp, NSError *err) {
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] hideLoader];
        [refreshControl endRefreshing];
        if(!err){
            [tableData removeAllObjects];
            for(NSDictionary *item in [resp objectForKey:@"data"]){
                User *expertUser = [User new];
                [expertUser parseDataFromJson:item];
                [tableData addObject:expertUser];
            }
            
            [self.broadcasterTable reloadData];
            
        }else{
            NSLog(@"Error----");
        }
    }];
}

#pragma TableView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tableData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BroadcasterTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BroadcasterTableCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController * broadCastVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DetailViewController"];
    [self presentViewController:broadCastVC animated:YES completion:nil];
}

#pragma mark - UISearchBar
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] showLoaderWithString:@"Loading..."];
//    keyString = searchBar.text;
//    [self loadData];
    [[self view] endEditing:YES];
}
@end
