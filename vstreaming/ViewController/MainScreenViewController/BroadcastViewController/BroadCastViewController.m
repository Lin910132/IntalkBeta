//
//  BroadCastViewController.m
//  vstreaming
//
//  Created by developer on 7/24/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "BroadCastViewController.h"
#import "IndustrySelectViewController.h"
#import "DetailViewController.h"
#import "ExpertSubmitViewController.h"


@interface BroadCastViewController () <IndustrySelectDelegate>

@end

@implementation BroadCastViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    [self getTagsInfo];
}


#pragma mark - Outlets
- (IBAction)btnIndustryClicked:(id)sender {
    IndustrySelectViewController *industrySVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"IndustrySelectViewController"];
    [self presentViewController:industrySVC animated:YES completion:nil];
}
- (IBAction)backBtnClicked:(id)sender {
    [self.tabBarController setSelectedIndex:0]; // switch to main tab
}

- (IBAction)btnBeginClicked:(id)sender {
    if([[User getInstance] getExpert] != Non_Expert){
        ExpertSubmitViewController *expertSVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ExpertSubmitViewController"];
        [self presentViewController:expertSVC animated:YES completion:nil];
    }else{
        DetailViewController *detailVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DetailViewController"];
        detailVC.liveStreamName = [Utility randomStringWithLength:10];
        [detailVC setScreenMode:Streaming_Host];
        [self presentViewController:detailVC animated:YES completion:nil];
    }
}

#pragma mark - Private
-(void) getTagsInfo{
    /*[InTalkAPI getAllTags:[[User getInstance] getUserToken]  competion:^(NSDictionary *json, NSError *error) {
        if(error == nil){
            
        }else{
            NSLog(@"%@", error);
        }
    }];*/
}

#pragma mark - IndustrySelectDelegate
-(void)selectIndustry:(NSString *)industryName{
    BroadCastViewController * broadCastVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"BroadcasterSelectController"];
    [self.navigationController pushViewController:broadCastVC animated:YES];
}
@end
