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
#import "LiveStreamingViewController.h"

@interface BroadCastViewController () <IndustrySelectDelegate>

@end

@implementation BroadCastViewController

- (IBAction)btnIndustryClicked:(id)sender {
    IndustrySelectViewController *industrySVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"IndustrySelectViewController"];
    [self presentViewController:industrySVC animated:YES completion:nil];
}
- (IBAction)backBtnClicked:(id)sender {
    [self.tabBarController setSelectedIndex:0]; // switch to main tab
}

- (IBAction)btnBeginClicked:(id)sender {
    /*DetailViewController *detailVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DetailViewController"];
    [self presentViewController:detailVC animated:YES completion:nil];
     */
    
    
    /*ExpertSubmitViewController *expertSVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ExpertSubmitViewController"];
    [self presentViewController:expertSVC animated:YES completion:nil];
     */
    
    LiveStreamingViewController *liveStreamingVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LiveStreamingViewController"];
    [self presentViewController:liveStreamingVC animated:YES completion:nil];
}

#pragma IndustrySelectDelegate
-(void)selectIndustry:(NSString *)industryName{
    BroadCastViewController * broadCastVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"BroadcasterSelectController"];
    [self.navigationController pushViewController:broadCastVC animated:YES];
}
@end
