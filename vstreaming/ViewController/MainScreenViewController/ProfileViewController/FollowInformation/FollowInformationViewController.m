//
//  FollowInformationViewController.m
//  vstreaming
//
//  Created by developer on 7/27/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "FollowInformationViewController.h"
#import "FollowTableCell.h"
#import "FollowerProfileViewController.h"
@interface FollowInformationViewController(){
    FollowScreenInfoType screenType;
}
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UITableView *followInfoTable;

@end

@implementation FollowInformationViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    [self initTitle];
}

-(void)initTitle{
    if(screenType == Follower_Screen){
        _lblTitle.text = @"Follower";
    }else{
        _lblTitle.text = @"Following";
    }
}

-(void)setScreenType:(FollowScreenInfoType)type{
    screenType = type;
}

- (IBAction)backBtnClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma TableView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FollowTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FollowTableCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FollowerProfileViewController *followerVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"FollowerProfileViewController"];
    [self presentViewController:followerVC animated:YES completion:nil];
}
@end
