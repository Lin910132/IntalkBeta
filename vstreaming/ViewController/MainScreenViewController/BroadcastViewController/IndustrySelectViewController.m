//
//  IndustrySelectViewController.m
//  vstreaming
//
//  Created by developer on 7/24/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "IndustrySelectViewController.h"
#import "IndustryTableCell.h"

@interface IndustrySelectViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation IndustrySelectViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.searchBar setImage:[UIImage imageNamed: @"icon_search.png"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
}
- (IBAction)btnCancelClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma TableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IndustryTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IndustryTableCell"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end
