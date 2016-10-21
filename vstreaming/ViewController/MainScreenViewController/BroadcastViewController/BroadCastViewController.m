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
#import "WXApiObject.h"
#import "WXApi.h"
#import "WeiboSDK.h"
#import "TencentAccess.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentMessageObject.h>
@interface BroadCastViewController () <IndustrySelectDelegate>{
    int sharingType;
}
@property (weak, nonatomic) IBOutlet UITextView *titleBroadCast;
@property (weak, nonatomic) IBOutlet UIButton *weiboBtn;
@property (weak, nonatomic) IBOutlet UIButton *wechatFriendBtn;
@property (weak, nonatomic) IBOutlet UIButton *wechatMoment;
@property (weak, nonatomic) IBOutlet UIButton *qqBtn;
@property (weak, nonatomic) IBOutlet UIButton *qZoneBtn;

@end

@implementation BroadCastViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    //self.titleBroadCast.placeholder = @"Title of Broadcasting";
    [self getTagsInfo];
}


-(void)shareToWeChatMoment:(NSString *) title description:(NSString*) descript streamUrl:(NSString *) streamUrl {
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = descript;
    WXVideoObject *ext = [WXVideoObject object];
    ext.videoUrl = streamUrl;
    message.mediaObject = ext;
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;
    [WXApi sendReq:req];
}

-(void)shareWechatFriend:(NSString *) title description:(NSString*) descript streamUrl:(NSString *) streamUrl {
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = descript;
    WXVideoObject *ext = [WXVideoObject object];
    ext.videoUrl = streamUrl;
    message.mediaObject = ext;
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    [WXApi sendReq:req];
}

-(void)shareWeibo:(NSString *) title description:(NSString*) descript streamUrl:(NSString *) streamUrl objID:(NSString *)objectID {
    WBAuthorizeRequest *authorize = [WBAuthorizeRequest request];
    authorize.redirectURI = @"2207922663";
    authorize.scope = @"all";
    authorize.userInfo = nil;
    
    WBMessageObject *message = [WBMessageObject message];
    //分享的具体描述内容
    message.text = @"微博分享测试";
    WBVideoObject *video = [WBVideoObject object];
    video.videoStreamUrl = streamUrl;
    video.videoUrl = streamUrl;
    video.title = title;
    video.description = descript;
    video.objectID = objectID;
    
    message.mediaObject = video;
    WBSendMessageToWeiboRequest *weiboRequest = [WBSendMessageToWeiboRequest requestWithMessage:message
                                                                                       authInfo:authorize
                                                                                   access_token:nil];
    
    weiboRequest.userInfo = nil;
    BOOL isSuccess =  [WeiboSDK sendRequest:weiboRequest];
    NSLog(@"分享是否成功 %d",isSuccess);
    
}

-(void)shareQq:(NSString *) title description:(NSString*) descript streamUrl:(NSString *) streamUrl {
    QQApiVideoObject *videoObj = [QQApiVideoObject objectWithURL:[NSURL URLWithString:streamUrl] title:title description:descript previewImageURL:nil];
    
    SendMessageToQQReq *req = [SendMessageToQQReq  reqWithContent:videoObj];
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    int i = 0;
    i++;
}

-(void)shareQzone:(NSString *) title description:(NSString*) descript streamUrl:(NSString *) streamUrl {
    QQApiVideoObject *videoObj = [QQApiVideoObject objectWithURL:[NSURL URLWithString:streamUrl] title:title description:descript previewImageURL:nil];
    SendMessageToQQReq *req = [SendMessageToQQReq  reqWithContent:videoObj];
    [QQApiInterface SendReqToQZone:req];
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
//    if([[User getInstance] getExpert] == Non_Expert){
//        ExpertSubmitViewController *expertSVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ExpertSubmitViewController"];
//        [self presentViewController:expertSVC animated:YES completion:nil];
//    }else{
        if([self.titleBroadCast.text isEqualToString:@""]){
            SHOWALLERT(@"Error", @"Please input the title of broadcast");
            return;
        }
        
        NSString *liveStreamName = [Utility randomStringWithLength:10];
        NSString *url = [NSString stringWithFormat:@"%@/%@", RTMP_SERVER_ADDRESS, liveStreamName];
        NSString *recordedVideoUrl = [NSString stringWithFormat:@"%@/mp4:%@.mp4", RTMP_VOD_SERVER_ADDRESS, liveStreamName];
//        [(AppDelegate *)[[UIApplication sharedApplication] delegate] showLoaderWithString:@"Start Broadcasting..."];
//        [InTalkAPI startBroadcastWithToken:[[User getInstance] getUserToken] Url:url recordedVidoUrl:recordedVideoUrl title:self.titleBroadCast.text completion:^(NSDictionary *json, NSError *error) {
//            [(AppDelegate *)[[UIApplication sharedApplication] delegate] hideLoader];
//            if(!error){
//                HomeTableItemModel *info = [HomeTableItemModel new];
//                info.item_id = [[json objectForKey:@"broadcastid"]intValue];
//                info.user_id = [[User getInstance] getUserID];
//                
//                DetailViewController *detailVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DetailViewController"];
//                detailVC.liveStreamName = liveStreamName;
//                detailVC.liveStreamTitle = self.titleBroadCast.text;
//                detailVC.recoredVideoUrl = recordedVideoUrl;
//                detailVC.info = info;
//                [detailVC setScreenMode:Streaming_Host];
//                [self presentViewController:detailVC animated:YES completion:nil];
//            }else {
//                SHOWALLERT(@"Broadcasting Request Error", error.localizedDescription);
//            }
//        }];
        
        if(sharingType == Weibo){
            [self shareWeibo:self.titleBroadCast.text description:@"Video" streamUrl:url objID:liveStreamName];
        }else if(sharingType == WechatFriend){
            [self shareWechatFriend:self.titleBroadCast.text description:@"Video" streamUrl:url];
        }else if(sharingType == WechatMoment){
            [self shareToWeChatMoment:self.titleBroadCast.text description:@"Video" streamUrl:url];
        }else if(sharingType == QQFriend){
            [self shareQq:self.titleBroadCast.text description:@"Video" streamUrl:url];
        }else if(sharingType == QZone){
            [self shareQzone:self.titleBroadCast.text description:@"Video" streamUrl:url];
        }
//    }
}

#pragma mark - Private
- (IBAction)btnShare:(id)sender {
    [self.weiboBtn setAlpha:0.5];
    [self.wechatFriendBtn setAlpha:0.5];
    [self.wechatMoment setAlpha:0.5];
    [self.qqBtn setAlpha:0.5];
    [self.qZoneBtn setAlpha:0.5];
    
    [(UIButton *)sender setAlpha:1];
    UIButton *pressed = (UIButton *) sender;
    if( pressed == self.weiboBtn){
        sharingType = Weibo;
    }else if( pressed == self.wechatFriendBtn){
        sharingType = WechatFriend;
    }else if( pressed == self.wechatMoment){
        sharingType = WechatMoment;
    }else if( pressed == self.qqBtn){
        sharingType = QQFriend;
    }else if( pressed == self.qZoneBtn){
        sharingType = QZone;
    }
}


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
