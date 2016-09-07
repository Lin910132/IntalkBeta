//
//  DetailViewController.m
//  vstreaming
//
//  Created by developer on 7/24/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "DetailViewController.h"
#import <AVKit/AVKit.h>
#import "QuestionViewController.h"
#import "UIView+Screenshot.h"
#import "QuestionTableCell.h"
#import <mach/mach_time.h>
#import <DAKeyboardControl.h>
#import <WowzaGoCoderSDK/WowzaGoCoderSDK.h>

@interface DetailViewController () <WZStatusCallback, WZVideoSink>{

    LiveStreamingScreenMode screenMode;
    BOOL isCaptureScreen;
    BOOL isFullMode;
    CGRect fullSizeFrame;
    CGRect originalSize;
    UIImage *sound_image;
    CIImage *frameImage;
    
    AVPlayer *player;
    AVPlayerViewController *controller;
}

@property (weak, nonatomic) IBOutlet UIView *selectedQst;
@property (weak, nonatomic) IBOutlet UIView *selectedAboutEpt;
@property (weak, nonatomic) IBOutlet UIView *selectedSuggestQt;
@property (weak, nonatomic) IBOutlet UIView *selectedQstHost;
@property (weak, nonatomic) IBOutlet UIView *selectedMeHost;
@property (weak, nonatomic) IBOutlet UIView *selectedSummaryHost;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITableView *questionTableView;
@property (weak, nonatomic) IBOutlet UIButton *btnCaptureMode;
@property (weak, nonatomic) IBOutlet UIButton *btnCameraMode;
@property (weak, nonatomic) IBOutlet UIView *tabBarView;
@property (weak, nonatomic) IBOutlet UIView *hostTabBarView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *btnBottomRight;
@property (weak, nonatomic) IBOutlet UITextField *bottomText;
@property (weak, nonatomic) IBOutlet UIButton *btnFullScreenMode;
@property (weak, nonatomic) IBOutlet UIView *bottomChatView;
@property (weak, nonatomic) IBOutlet UIView *fullScreenView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sharingBtnTopConstraint;
@property (weak, nonatomic) IBOutlet UIView *fullScreenHostSideProfile;
@property (weak, nonatomic) IBOutlet UIView *fullScreenClientSideProfile;
@property (weak, nonatomic) IBOutlet UIButton *answer_full_1;
@property (weak, nonatomic) IBOutlet UIButton *answer_full_2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewBottomConstraint;

@property (weak, nonatomic) IBOutlet UIButton *comment_1;
@property (weak, nonatomic) IBOutlet UIButton *comment_2;
@property (weak, nonatomic) IBOutlet UIButton *btnClose;
@property (weak, nonatomic) IBOutlet UIButton *btnCloseMain;
@property (weak, nonatomic) IBOutlet UILabel *lblStreamFinished;

@property (weak, nonatomic) IBOutlet UIImageView *small_sound_img;
@property (weak, nonatomic) IBOutlet UIImageView *full_sound_img;

@property (nonatomic, strong) WowzaGoCoder *goCoder;

@property (nonatomic, strong) WZCameraPreview *goCoderCameraPreview;
@end


@implementation DetailViewController

-(void)viewWillAppear:(BOOL)animated{
        __weak typeof(self) weakSelf = self;
        [self.view addKeyboardPanningWithFrameBasedActionHandler:nil constraintBasedActionHandler:^(CGRect keyboardFrameInView, BOOL opening, BOOL closing){
            static CGFloat y;
    
            if (opening || y == 0)
            {
                y = keyboardFrameInView.origin.y + keyboardFrameInView.size.height;
            }
            if (closing){
    
                weakSelf.bottomViewBottomConstraint.constant = 0;
                [weakSelf.view layoutIfNeeded];
            }else {
    
                weakSelf.bottomViewBottomConstraint.constant = y - keyboardFrameInView.origin.y;
            }
        }];
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord
                                     withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker
                                           error:nil];
    
    if(screenMode == Streaming_Host) {
        [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    if(screenMode == Streaming_Host) {
        [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    about key board
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
//    end
    
    
    [self initTableView];
    selectedTab = QuestionTabSelected;
    [self setSelectMarksHiddenQuests:NO Expert:YES SuggestQt:YES];
    
    isFullMode = false;
    fullSizeFrame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    originalSize = _imageView.frame;
    
    [_fullScreenView setHidden:YES];
    [_btnClose setHidden:YES];
    [_lblStreamFinished setHidden:YES];
    [_small_sound_img setHidden:YES];
    [_full_sound_img setHidden:YES];
    
    if(screenMode == Streaming_Client){
        [self playLiveStreamingVideo];
        [_btnCaptureMode setHidden:YES];
        [_btnCameraMode  setHidden:YES];
        [_bottomText setHidden:YES];
        [_fullScreenClientSideProfile setHidden:NO];
        
        [_btnBottomRight setImage:[UIImage imageNamed:@"icon_gift.png"] forState:UIControlStateNormal];
        
        [self buttonInit];
        [_hostTabBarView setHidden:YES];
        
    }else if(screenMode == Streaming_Host){
        sound_image = [UIImage imageNamed:@"sound_img.png"];
        frameImage = [[CIImage alloc] initWithCGImage:sound_image.CGImage options:nil];
        
        [self initWowzaSDK];
        [_comment_1 setTitle:@"3" forState:UIControlStateNormal];
        [_comment_2 setTitle:@"7" forState:UIControlStateNormal];
    
        isCaptureScreen = true;
        [self startLiveStreamingVideo];
        [_bottomText setHidden:NO];
        [_fullScreenHostSideProfile setHidden:NO];
        [_btnBottomRight setImage:[UIImage imageNamed:@"icon_send.png"] forState:UIControlStateNormal];
    }else{
        SHOWALLERT(@"Error", @"Configure Error on Setting Screen Mode");
    }
}

#pragma -mark Private
-(void)initWowzaSDK{
    NSError *goCoderLicensingError = [WowzaGoCoder registerLicenseKey:@"GOSK-AF42-0103-BAEF-6178-DA48"];
    if (goCoderLicensingError != nil) {
        // Log license key registration failure
        NSLog(@"%@", [goCoderLicensingError localizedDescription]);
    } else {
        // Initialize the GoCoder SDK
        self.goCoder = [WowzaGoCoder sharedInstance];
        
        
        [WowzaGoCoder requestPermissionForType:WowzaGoCoderPermissionTypeCamera response:^(WowzaGoCoderCapturePermission permission) {
            NSLog(@"Camera permission is: %@", permission == WowzaGoCoderCapturePermissionAuthorized ? @"authorized" : @"denied");
        }];
        
        [WowzaGoCoder requestPermissionForType:WowzaGoCoderPermissionTypeMicrophone response:^(WowzaGoCoderCapturePermission permission) {
            NSLog(@"Microphone permission is: %@", permission == WowzaGoCoderCapturePermissionAuthorized ? @"authorized" : @"denied");
        }];
    }
}

-(void)dismissKeyboard {
    [self.view endEditing:YES];
}

-(void) buttonInit{
    [_answer_full_1 setHidden:YES];
    [_answer_full_2 setHidden:YES];
}

-(void)initTableView{
    self.questionTableView.scrollEnabled = NO;
    self.questionTableView.separatorColor = [UIColor clearColor];
    self.questionTableView.allowsSelection = NO;
}


// for playing streaming video
-(void) playLiveStreamingVideo{
    NSURL *videoURL = [NSURL URLWithString:PLAY_LIST_URL];
    
    player = [AVPlayer playerWithURL:videoURL];
    
    controller = [[AVPlayerViewController alloc]init];
    controller.player = player;
    controller.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    [self addChildViewController:controller];
    [self.imageView addSubview:controller.view];
    
    [controller.view setFrame:_imageView.bounds];
    
    [self doConnect];
}

//for capturing video on hosting side
-(void) startLiveStreamingVideo{
    if(self.goCoder != nil) {
        
        WowzaConfig *broadcastConfig = self.goCoder.config;
        [broadcastConfig loadPreset:WZFrameSizePreset640x480];
        broadcastConfig.capturedVideoRotates = false;
        broadcastConfig.broadcastScaleMode = WZBroadcastScaleModeAspectFill;
        broadcastConfig.hostAddress = @"10.70.5.1";
        //broadcastConfig.hostAddress = @"www.intalk.tv";
        broadcastConfig.applicationName = @"live";
        broadcastConfig.streamName = @"myStream";
        
        
        self.goCoder.config = broadcastConfig;
        [self.goCoder registerVideoSink:self];
        self.goCoder.cameraView = _imageView;
        
        self.goCoderCameraPreview = self.goCoder.cameraPreview;
        self.goCoderCameraPreview.previewGravity = WZCameraPreviewGravityResizeAspectFill;
        [self.goCoderCameraPreview startPreview];
        [self doConnect];
    }
}

-(void) doConnect{
    if(screenMode == Streaming_Client) {
        
        [player play];
        
        
        
    }else if(screenMode == Streaming_Host){
        [self.goCoder startStreaming:self];
    }else{
        SHOWALLERT(@"Error", @"Configure Error on Setting Screen Mode");
    }
}

-(void)setDisconnect {
    if( screenMode == Streaming_Client){
        
    }else if(screenMode == Streaming_Host){
        [_goCoder unregisterVideoSink:self];
        [_goCoder endStreaming:self];
        _goCoder = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backBtnPressed:(id)sender {
    [self setDisconnect];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)btnCaptureMode:(id)sender {
    isCaptureScreen = !isCaptureScreen;
    if(isCaptureScreen == false) {
        [_full_sound_img setHidden:NO];
        [_small_sound_img setHidden:NO];
    }else{
        [_small_sound_img setHidden:YES];
        [_full_sound_img setHidden:YES];
    }
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
- (IBAction)btnAskClicked:(id)sender {
    QuestionViewController *questionVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"QuestionViewController"];
    [self presentViewController:questionVC animated:YES completion:nil];
}
- (IBAction)btnFullScreenMode:(id)sender {
    isFullMode = !isFullMode;
    [self switchViewMode];
    
    NSLog(@"%f", _imageView.frame.size.height);
}
-(void)switchViewMode{
    if(isFullMode == true) {
        if(screenMode == Streaming_Client){
            self.sharingBtnTopConstraint.constant = 35.0f;
            [_btnCloseMain setHidden:YES];
            [_bottomView setHidden:YES];
            [controller.view setFrame:fullSizeFrame];
        }else{
            [_btnCloseMain setHidden:YES];
            [_goCoderCameraPreview.previewLayer setFrame:fullSizeFrame];
        }
        
        [self.tabBarView setHidden:YES];
        [self.questionTableView setHidden:YES];
        [_btnFullScreenMode setImage:[UIImage imageNamed:@"icon_mini_mode.png"] forState:UIControlStateNormal];
        [self.fullScreenView setHidden:NO];
        [_btnClose setHidden:NO];
        
    }else {
        if(screenMode == Streaming_Client){
            self.sharingBtnTopConstraint.constant = 2.0f;
            [_bottomView setHidden:NO];
            [_btnCloseMain setHidden:NO];
            [controller.view setFrame:_imageView.bounds];
        }else{
            [_btnCloseMain setHidden:NO];
            [_goCoderCameraPreview.previewLayer setFrame:originalSize];
        }
        
        [self.bottomView setHidden:NO];
        [self.tabBarView setHidden:NO];
        [self.questionTableView setHidden:NO];
        [_btnFullScreenMode setImage:[UIImage imageNamed:@"icon_full_mode.png"] forState:UIControlStateNormal];
        [self.fullScreenView setHidden:YES];
        [_btnClose setHidden:YES];
    }
    
}

- (IBAction)btnUpFrontandBackCameraMode:(id)sender {

    [_goCoderCameraPreview switchCamera];
}

-(void) setSelectMarksHiddenQuests:(BOOL)qs Expert:(BOOL)ae SuggestQt:(BOOL)sq{
    [self.selectedQst setHidden:qs];
    [self.selectedAboutEpt setHidden:ae];
    [self.selectedSuggestQt setHidden:sq];
    
    [_selectedQstHost setHidden:qs];
    [_selectedMeHost setHidden:ae];
    [_selectedSummaryHost setHidden:sq];
}


-(void)setScreenMode:(LiveStreamingScreenMode)mode{
    screenMode = mode;  //this set this screen is the screen of hosting side or client side
}

-(void)pixelBufferShouldBePublished:(CVPixelBufferRef)pixelBuffer timestamp:(int)timestamp
{
    NSLog(@"width:%zu height:%zu",CVPixelBufferGetWidth(pixelBuffer),CVPixelBufferGetHeight(pixelBuffer));
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
        QuestionTableCell *questionCell = [tableView dequeueReusableCellWithIdentifier:@"QuestionTableCell"];
        [questionCell setScreenMode:screenMode];
        cell = questionCell;
    }else if(selectedTab == ExpertTabSelected){
        cell = [tableView dequeueReusableCellWithIdentifier:@"ExpertTableCell"];
    }else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"SuggestTableCell"];
    }
    return cell;
}

#pragma mark - WZStatusCallback Protocol Instance Methods

-(void)onWZStatus:(WZStatus *)status{
    
}

-(void)onWZError:(WZStatus *)status{
    
}

-(void)onWZEvent:(WZStatus *)status{
    
}

#pragma mark - WZVideoSink

#warning Don't implement this protocol unless your application makes use of it
- (void) videoFrameWasCaptured:(nonnull CVImageBufferRef)imageBuffer framePresentationTime:(CMTime)framePresentationTime frameDuration:(CMTime)frameDuration {
    if (self.goCoder.isStreaming) {
        
        if (isCaptureScreen == false) {
            size_t width = CVPixelBufferGetWidth(imageBuffer);
            size_t height = CVPixelBufferGetHeight(imageBuffer);
            
            CIVector *cropRect =[CIVector vectorWithX:0 Y:0 Z: width W: height];
            
            CIFilter *cropFilter = [CIFilter filterWithName:@"CICrop"];
            
            [cropFilter setValue:frameImage forKey:@"inputImage"];
            [cropFilter setValue:cropRect forKey:@"inputRectangle"];
            
            frameImage = [cropFilter valueForKey:@"outputImage"];
            
            //CIFilter *scalefilter = [CIFilter filterWithName:@"CIPhotoEffectTonal"];
            //[grayFilter setValue:frameImage forKeyPath:@"inputImage"];
            //frameImage = [grayFilter outputImage];
            
            CIContext * context = [CIContext contextWithOptions:nil];
            
            [context render:[CIImage imageWithColor:[CIColor colorWithRed:45/255.0 green:123/255.0 blue:187/255.0]] toCVPixelBuffer:imageBuffer];
            [context render:frameImage toCVPixelBuffer:imageBuffer];
        }
        
    }
}

- (void) videoCaptureInterruptionStarted {
//    if (!self.goCoderConfig.backgroundBroadcastEnabled) {
//        [self.goCoder endStreaming:self];
//    }
}

- (void) videoCaptureUsingQueue:(nullable dispatch_queue_t)queue {
//    self.video_capture_queue = queue;
}

@end

