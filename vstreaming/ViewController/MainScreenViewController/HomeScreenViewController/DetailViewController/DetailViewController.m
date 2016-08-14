//
//  DetailViewController.m
//  vstreaming
//
//  Created by developer on 7/24/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "DetailViewController.h"
#import <AVKit/AVKit.h>
#import "MediaStreamPlayer.h"
#import "MemoryTicker.h"
#import "VideoPlayer.h"
#import "MPMediaDecoder.h"
#import "BroadcastStreamClient.h"

@interface DetailViewController () <MPIMediaStreamEvent> {
    MPMediaDecoder          *decoder;       // variable for play
    
    BroadcastStreamClient   *upstream;      //variable for live streaming
    MPVideoResolution       resolution;     //variable for live streaming
    AVCaptureVideoOrientation orientation;  //variable for live streaming
    
    LiveStreamingScreenMode screenMode;
}
@property (weak, nonatomic) IBOutlet UIView *selectedQst;
@property (weak, nonatomic) IBOutlet UIView *selectedAboutEpt;
@property (weak, nonatomic) IBOutlet UIView *selectedSuggestQt;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITableView *questionTableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingBar;
@end



@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    selectedTab = QuestionTabSelected;
    [self setSelectMarksHiddenQuests:NO Expert:YES SuggestQt:YES];
    
    if(screenMode == Streaming_Client){
        [self playLiveStreamingVideo];
    }else if(screenMode == Streaming_Host){
        [self startLiveStreamingVideo];
    }else{
        SHOWALLERT(@"Error", @"Configure Error on Setting Screen Mode");
    }
}

-(void)initTableView{
    self.questionTableView.scrollEnabled = NO;
    self.questionTableView.separatorColor = [UIColor clearColor];
    self.questionTableView.allowsSelection = NO;
}


// for playing streaming video
-(void) playLiveStreamingVideo{
    decoder = [[MPMediaDecoder alloc] initWithView:_imageView];
    decoder.delegate = self;
    decoder.isRealTime = YES;
    decoder.orientation = UIImageOrientationUp;
    
    [self doConnect];
    [_loadingBar setHidden:NO];
    [_loadingBar startAnimating];
}

-(void) startLiveStreamingVideo{
    resolution = RESOLUTION_VGA;
    upstream = [[BroadcastStreamClient alloc] init:RTMP_SERVER_ADDRESS resolution:resolution];
    
    upstream.delegate = self;
    upstream.videoCodecId = MP_VIDEO_CODEC_H264;
    upstream.audioCodecId = MP_AUDIO_CODEC_AAC;
    orientation = AVCaptureVideoOrientationPortrait;
    [upstream setVideoOrientation:orientation];
    [upstream stream:@"myStream" publishType:PUBLISH_LIVE];
    
    [self doConnect];
}
-(void) doConnect{
    if(screenMode == Streaming_Client) {
        [decoder setupStream:[NSString stringWithFormat:@"%@/%@", RTMP_SERVER_ADDRESS, @"myStream"]];
    }else if(screenMode == Streaming_Host){
        [upstream disconnect];
    }else{
        SHOWALLERT(@"Error", @"Configure Error on Setting Screen Mode");
    }
}

-(void)setDisconnect {
    if( screenMode == Streaming_Client){
        [decoder cleanupStream];
        decoder = nil;
    }else if(screenMode == Streaming_Host){
        [upstream teardownPreviewLayer];
        upstream = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backBtnPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self setDisconnect];
}
- (IBAction)btnQuestionClicked:(id)sender {
    [self setSelectMarksHiddenQuests:NO Expert:YES SuggestQt:YES];
    selectedTab = QuestionTabSelected;
    [self.questionTableView reloadData];
}
- (IBAction)btnAboutEptClicked:(id)sender {
    [self setSelectMarksHiddenQuests:YES Expert:NO SuggestQt:YES];
    selectedTab = ExpertTabSelected;
    [self.questionTableView reloadData];
}
- (IBAction)btnSuggestQtClicked:(id)sender {
    [self setSelectMarksHiddenQuests:YES Expert:YES SuggestQt:NO];
    selectedTab = SuggestQTTabSelected;
    [self.questionTableView reloadData];
}

-(void) setSelectMarksHiddenQuests:(BOOL)qs Expert:(BOOL)ae SuggestQt:(BOOL)sq{
    [self.selectedQst setHidden:qs];
    [self.selectedAboutEpt setHidden:ae];
    [self.selectedSuggestQt setHidden:sq];
}


-(void)setScreenMode:(LiveStreamingScreenMode)mode{
    screenMode = mode;  //this set this screen is the screen of hosting side or client side
}
#pragma Table View delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if(selectedTab == QuestionTabSelected){
        cell = [tableView dequeueReusableCellWithIdentifier:@"QuestionTableCell"];
    }else if(selectedTab == ExpertTabSelected){
        cell = [tableView dequeueReusableCellWithIdentifier:@"ExpertTableCell"];
    }else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"SuggestTableCell"];
    }
    return cell;
}

#pragma marks MPIMediaStreamEvent Methods
-(void)stateChanged:(id)sender state:(MPMediaStreamState)state description:(NSString *)description{
    switch (state) {
        case CONN_DISCONNECTED: {
            [self setDisconnect];
            
        }break;
        case CONN_CONNECTED: {
            [upstream start];
            
        }break;
        case STREAM_CREATED: {
            if(screenMode == Streaming_Client){
                [decoder resume];
            }
        }break;
            
        case STREAM_PLAYING: {
            if(screenMode == Streaming_Client){
                [MPMediaData routeAudioToSpeaker];
                [_loadingBar setHidden:YES];
                [_loadingBar stopAnimating];
            }else if(screenMode == Streaming_Host){
                [upstream setPreviewLayer:imageView];
            }
        }break;
            
        default:
            break;
    }
}

-(void)connectFailed:(id)sender code:(int)code description:(NSString *)description{
    NSLog(@"DetailViewController - Live connection failed");
    [self setDisconnect];
}

@end
