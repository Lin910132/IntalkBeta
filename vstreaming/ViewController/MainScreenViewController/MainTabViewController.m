//
//  MainTabViewController.m
//  vstreaming
//
//  Created by developer on 7/24/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "MainTabViewController.h"

@interface MainTabViewController ()

@end

@implementation MainTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    [self getMyInfo];
    [self getTagsInfo];
    [self initBroadcastIcon];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initBroadcastIcon {
    UITabBarItem * tabBarBroadcast = [self.tabBar.items objectAtIndex:2];
    tabBarBroadcast.selectedImage = [[UIImage imageNamed:@"icon_broadcast.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarBroadcast.image = [[UIImage imageNamed:@"icon_broadcast.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
#pragma mark - Private
-(void) getMyInfo{
    [InTalkAPI getMyInfoByToken:[[User getInstance] getUserToken] competion:^(NSDictionary * res, NSError * err) {
        if(err == nil) {
            [[User getInstance] parseDataFromJson:res];
        }else{
            SHOWALLERT(@"Get My Info Request Error", err.localizedDescription);
        }
    }];
}

-(void) getTagsInfo{
    [InTalkAPI getAllTags:[[User getInstance] getUserToken] competion:^(NSDictionary * response, NSError * err){
        if(err == nil){
            NSLog(@"%@", response);
            DataManager *dataManager = [DataManager getInstance];
            if(!dataManager.allTags){
                dataManager.allTags = [NSMutableArray new];
            }
            for(NSDictionary * itemData in [response objectForKey:@"data"]){
                TagModel *tagItem = [TagModel parseDataFromJson:itemData];
                [dataManager.allTags addObject:tagItem];
            }
        }else{
            SHOWALLERT(@"Get Tags Request Error", err.localizedDescription);
        }
    }];
}

#pragma mark - TabBarController Delegate
//-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
//    if(item.tag ==  0){
//        UINavigationController * home = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeNavigationController"];
//        [self presentViewController:home animated:NO completion:nil];
//    }else if(item.tag == 1){
//        UINavigationController * grid = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"GridNavigationController"];
//        [grid popToRootViewControllerAnimated:NO];
//        [self presentViewController:grid animated:NO completion:nil];
//    }else if(item.tag == 2){
//        UIViewController * broadcast = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"BroadCastViewController"];
//        [self presentViewController:broadcast animated:NO completion:nil];
//    }else if(item.tag == 3){
//        UIViewController * message = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MessagesViewController"];
//        [self presentViewController:message animated:NO completion:nil];
//    }else if(item.tag == 4){
//        UIViewController * profile = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MainProfileViewController"];
//        [self presentViewController:profile animated:NO completion:nil];
//    }
//}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    NSUInteger index = tabBarController.selectedIndex;
    if(index == 1 || index == 3) {
        UINavigationController *grid  = (UINavigationController*)viewController;
        [grid popToRootViewControllerAnimated:NO];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
