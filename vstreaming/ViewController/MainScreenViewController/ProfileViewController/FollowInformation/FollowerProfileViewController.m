//
//  FollowerProfileViewController.m
//  vstreaming
//
//  Created by developer on 7/27/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "FollowerProfileViewController.h"
#import "ProfileExpertTableCell.h"
#import "ShowTableCell.h"
#import "DetailViewController.h"
@interface FollowerProfileViewController()
@property (weak, nonatomic) IBOutlet UIButton *expertBtn;
@property (weak, nonatomic) IBOutlet UIButton *showBtn;
@property (weak, nonatomic) IBOutlet UIView *expertSelectedTab;
@property (weak, nonatomic) IBOutlet UIView *showSelectedTab;
@property (weak, nonatomic) IBOutlet UITableView *infoTableView;

@end

@implementation FollowerProfileViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    [self setSelectMarksHiddenQuests:NO Expert:YES];
}

- (IBAction)expertBtnClicked:(id)sender {
    selectedTab = ProfileExpertTabSelected;
    [self setSelectMarksHiddenQuests:NO Expert:YES];
    self.infoTableView.scrollEnabled = NO;
    [self.infoTableView reloadData];
    self.infoTableView.scrollEnabled = NO;
}
- (IBAction)showBtnClicked:(id)sender {
    selectedTab = ShowTabSelected;
    [self setSelectMarksHiddenQuests:YES Expert:NO];
    self.infoTableView.scrollEnabled = YES;
    [self.infoTableView reloadData];
    self.infoTableView.scrollEnabled = YES;
}

- (IBAction)backBtnClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) setSelectMarksHiddenQuests:(BOOL)expertTab Expert:(BOOL)showTab{
    [self.expertSelectedTab setHidden:expertTab];
    [self.showSelectedTab setHidden:showTab];
    
}

#pragma TableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(selectedTab == ProfileExpertTabSelected){
        return 1;
    }else{
        return 5;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if(selectedTab == ProfileExpertTabSelected){
        cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileExpertTableCell"];
    }else if(selectedTab == ShowTabSelected){
        cell = [tableView dequeueReusableCellWithIdentifier:@"ShowTableCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(selectedTab == ProfileExpertTabSelected){
        return tableView.frame.size.height;
    }else{
        return 380;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(selectedTab == ShowTabSelected){
        DetailViewController *detailVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DetailViewController"];
        [self presentViewController:detailVC animated:YES completion:nil];
    }
}
@end
