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
@interface ExpertSearchViewController() <UITableViewDelegate, UITableViewDataSource>{
    ExpertSearchTapType selectedTab;
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
    [self.searchBar setImage:[UIImage imageNamed: @"icon_search.png"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    
    [self.expertBtn setTitle:[[User getInstance] getName] forState:UIControlStateNormal];
    [self loadExpertData];
}
#pragma mark - Private
-(void) loadExpertData{
    [InTalkAPI searchExpert:[[User getInstance]getUserToken] tagID:self.tagID limit:10 offset:0 competion:^(NSDictionary *resp, NSError *err) {
        if(!err){
            NSLog(@"%@", resp);
        }else{
            NSLog(@"Error----");
        }
    }];
}

- (IBAction)backBtnClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)expertBtnClicked:(id)sender {
    selectedTab = Expert_Tab;
    [_expertSelected setHidden:NO];
    [_tagSelected setHidden:YES];
}
- (IBAction)tagBtnClicked:(id)sender {
    selectedTab = Tag_Tab;
    [_expertSelected setHidden:YES];
    [_tagSelected setHidden:NO];
}

#pragma TableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ExpertSearchTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExpertSearchTableCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detailVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DetailViewController"];
    [self presentViewController:detailVC animated:YES completion:nil];
}
@end
