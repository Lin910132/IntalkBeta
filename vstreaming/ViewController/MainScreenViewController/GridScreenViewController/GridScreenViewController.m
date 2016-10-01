//
//  GridScreenViewController.m
//  vstreaming
//
//  Created by developer on 7/24/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "GridScreenViewController.h"
#import "CollectionViewCell.h"
#import "CustomGridFlowLayout.h"
#import "BroadCastViewController.h"
#import "AppDelegate.h"
#import <UIImageView+AFNetworking.h>
@interface GridScreenViewController (){
    NSMutableArray *tagArray;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation GridScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initVariable];
    self.collectionView.collectionViewLayout = [[CustomGridFlowLayout alloc]init];
    [self.searchBar setImage:[UIImage imageNamed: @"icon_search.png"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [self getTagsInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Private
-(void) initVariable{
    tagArray = [NSMutableArray new];
}

-(void) getTagsInfo{
    [tagArray removeAllObjects];
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] showLoader];
    [InTalkAPI getAllTags:[[User getInstance] getUserToken] competion:^(NSDictionary * response, NSError * err){
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] hideLoader];
        if(err == nil){
            NSLog(@"%@", response);
            for(NSDictionary * itemData in [response objectForKey:@"data"]){
                TagModel *tagItem = [TagModel parseDataFromJson:itemData];
                [tagArray addObject:tagItem];
            }
            [self.collectionView reloadData];
        }else{
            NSLog(@"Get All Tags API occurs such Error %@", err);
        }
    }];
}

#pragma CollectionView Delegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [tagArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * gridItemIdentifier = @"CollectionViewCell";
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:gridItemIdentifier forIndexPath:indexPath];
    TagModel *tagItem = [tagArray objectAtIndex:indexPath.row];
    
    cell.tagName.text = tagItem.tagName;
    [cell.tagLogo setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:tagItem.tagImg]]
                            placeholderImage:nil
                                     success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                         [cell.tagLogo setImage:image];
                                     }
                                     failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                     }];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    BroadCastViewController * broadCastVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"BroadcasterSelectController"];
    //[self.navigationController pushViewController:broadCastVC animated:YES];
    [self presentViewController:broadCastVC animated:YES completion:nil];
}
@end
