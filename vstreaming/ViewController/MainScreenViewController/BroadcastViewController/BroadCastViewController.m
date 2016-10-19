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
#import <UITextView+Placeholder.h>

@interface BroadCastViewController () <IndustrySelectDelegate>
@property (weak, nonatomic) IBOutlet UITextView *titleBroadCast;

@end

@implementation BroadCastViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    //self.titleBroadCast.placeholder = @"Title of Broadcasting";
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
    if([[User getInstance] getExpert] == Non_Expert){
        ExpertSubmitViewController *expertSVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ExpertSubmitViewController"];
        [self presentViewController:expertSVC animated:YES completion:nil];
    }else{
        if([self.titleBroadCast.text isEqualToString:@""]){
            SHOWALLERT(@"Error", @"Please input the title of broadcast");
            return;
        }
        
        NSString *liveStreamName = [Utility randomStringWithLength:10];
        NSString *url = [NSString stringWithFormat:@"%@/%@", RTMP_SERVER_ADDRESS, liveStreamName];
        NSString *recordedVideoUrl = [NSString stringWithFormat:@"%@/%@.mp4", RTMP_SERVER_ADDRESS, liveStreamName];
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] showLoaderWithString:@"Start Broadcasting..."];
        [InTalkAPI startBroadcastWithToken:[[User getInstance] getUserToken] Url:url title:self.titleBroadCast.text completion:^(NSDictionary *json, NSError *error) {
            [(AppDelegate *)[[UIApplication sharedApplication] delegate] hideLoader];
            if(!error){
                HomeTableItemModel *info = [HomeTableItemModel new];
                info.item_id = [[json objectForKey:@"broadcastid"]intValue];
                info.user_id = [[User getInstance] getUserID];
                
                DetailViewController *detailVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DetailViewController"];
                detailVC.liveStreamName = liveStreamName;
                detailVC.liveStreamTitle = self.titleBroadCast.text;
                detailVC.info = info;
                [detailVC setScreenMode:Streaming_Host];
                [self presentViewController:detailVC animated:YES completion:nil];
            }else {
                SHOWALLERT(@"Broadcasting Request Error", error.localizedDescription);
            }
        }];
        
        
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
