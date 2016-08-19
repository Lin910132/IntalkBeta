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
#import "DEBUG.h"
#import "MPMediaDecoder.h"
#import "BroadcastStreamClient.h"
#import "UIView+Screenshot.h"
#import <mach/mach_time.h>
@interface DetailViewController () <MPIMediaStreamEvent> {
    MPMediaDecoder          *decoder;       // variable for play
    
    
    BroadcastStreamClient   *upstream;      //variable for live streaming
    MPVideoResolution       resolution;     //variable for live streaming
    FramesPlayer                *_player;   //variable for live streaming
    FramesPlayer                *fullplayer;   //variable for live streaming
    AVCaptureVideoOrientation orientation;  //variable for live streaming
    AVCaptureSession            *session;
    AVCaptureVideoDataOutput    *videoDataOutput;
    dispatch_queue_t            videoDataOutputQueue;
    UIImage                     *capturedImage;
    
    
    LiveStreamingScreenMode screenMode;
    BOOL isCaptureScreen;
    BOOL isFullMode;
    BOOL isBackCamera;
    BOOL isChangingScreen;
    BOOL                        isPhotoPicking;
}

@property (weak, nonatomic) IBOutlet UIView *selectedQst;
@property (weak, nonatomic) IBOutlet UIView *selectedAboutEpt;
@property (weak, nonatomic) IBOutlet UIView *selectedSuggestQt;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITableView *questionTableView;
@property (weak, nonatomic) IBOutlet UIButton *btnCaptureMode;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingBar;
@property (weak, nonatomic) IBOutlet UIImageView *fullVideoView;
@property (weak, nonatomic) IBOutlet UIButton *btnCameraMode;
@property (weak, nonatomic) IBOutlet UIView *tabBarView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *btnBottomRight;
@property (weak, nonatomic) IBOutlet UITextField *bottomText;
@property (weak, nonatomic) IBOutlet UIButton *btnFullScreenMode;
@property (weak, nonatomic) IBOutlet UIView *bottomChatView;
@property (weak, nonatomic) IBOutlet UIView *fullScreenView;

@end


@interface DetailViewController(CaptureProcessing) <AVCaptureVideoDataOutputSampleBufferDelegate>
-(void)setupAVCapture;
-(void)teardownAVCapture;
-(void)flushFrame;
@end

@interface DetailViewController(ImageProcessing)
-(CVPixelBufferRef)pixelBufferFromCGImage:(CGImageRef)image;
-(CGImageRef)imageFromPixelBuffer:(CVPixelBufferRef)frameBuffer;
-(CGImageRef)imageFromImageBuffer:(CVImageBufferRef)imageBuffer;
- (UIImage *) imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer;
@end


@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    selectedTab = QuestionTabSelected;
    [self setSelectMarksHiddenQuests:NO Expert:YES SuggestQt:YES];
    
    isFullMode = false; isBackCamera = true; isChangingScreen = false;
    
    
    [_fullScreenView setHidden:YES];
    
    if(screenMode == Streaming_Client){
        [self playLiveStreamingVideo];
        [_btnCaptureMode setHidden:YES];
        [_btnCameraMode  setHidden:YES];
        [_bottomText setHidden:YES];
        [_btnBottomRight setImage:[UIImage imageNamed:@"icon_gift.png"] forState:UIControlStateNormal];
    }else if(screenMode == Streaming_Host){
        isCaptureScreen = true;
        [self startLiveStreamingVideo];
        [_bottomText setHidden:NO];
        [_btnBottomRight setImage:[UIImage imageNamed:@"icon_send.png"] forState:UIControlStateNormal];
        [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(flushFrame) userInfo:nil repeats:YES];
    }else{
        SHOWALLERT(@"Error", @"Configure Error on Setting Screen Mode");
    }
    [_loadingBar setHidden:NO];
    [_loadingBar startAnimating];
}

-(void)initTableView{
    self.questionTableView.scrollEnabled = NO;
    self.questionTableView.separatorColor = [UIColor clearColor];
    self.questionTableView.allowsSelection = NO;
}


// for playing streaming video
-(void) playLiveStreamingVideo{
    if(isFullMode == false) {
        decoder = [[MPMediaDecoder alloc] initWithView:_imageView];
    }else {
        decoder = [[MPMediaDecoder alloc] initWithView:_fullVideoView];
    }
    decoder.delegate = self;
    decoder.isRealTime = YES;
    decoder.orientation = UIImageOrientationRight;
    
    [self doConnect];
}

//for capturing video on hosting side
-(void) startLiveStreamingVideo{
    _player = [[FramesPlayer alloc] initWithView:_imageView];
    fullplayer = [[FramesPlayer alloc] initWithView:_fullVideoView];
    
    resolution = RESOLUTION_VGA;
    [self setupAVCapture];
    
    upstream = [[BroadcastStreamClient alloc] init:RTMP_SERVER_ADDRESS resolution:resolution];
    [upstream setVideoMode:VIDEO_CUSTOM];
    upstream.delegate = self;
    upstream.videoCodecId = MP_VIDEO_CODEC_H264;
    upstream.audioCodecId = MP_AUDIO_CODEC_AAC;
    [upstream stream:@"myStream" publishType:PUBLISH_LIVE];
}

-(int64_t)getTimestampMs {
    mach_timebase_info_data_t info;
    mach_timebase_info(&info);
    return 1e-6*mach_absolute_time()*info.numer/info.denom;
}

-(void) doConnect{
    if(screenMode == Streaming_Client) {
        [decoder setupStream:[NSString stringWithFormat:@"%@/%@", RTMP_SERVER_ADDRESS, @"myStream"]];
    }else if(screenMode == Streaming_Host){
        [upstream disconnect];
        [upstream stream:@"myStream" publishType:PUBLISH_LIVE];
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
        if(upstream != nil){
            [upstream disconnect];
        }
        upstream = nil;
        [self teardownAVCapture];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backBtnPressed:(id)sender {
    [self setDisconnect];
}
- (IBAction)btnCaptureMode:(id)sender {
    isCaptureScreen = !isCaptureScreen;
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
    if(screenMode == Streaming_Host){
        [upstream setVideoMode:VIDEO_CAPTURE];
    }
}
- (IBAction)btnFullScreenMode:(id)sender {
    isFullMode = !isFullMode;
    [self switchViewMode];
}
-(void)switchViewMode{
    if(isFullMode == true) {
        if(screenMode == Streaming_Client){
            [self.bottomView setHidden:YES];
            decoder.streamImageView =_fullVideoView;
        }
        
        [self.tabBarView setHidden:YES];
        [self.questionTableView setHidden:YES];
        [_btnFullScreenMode setImage:[UIImage imageNamed:@"icon_mini_mode.png"] forState:UIControlStateNormal];
        [self.fullScreenView setHidden:NO];
    }else {
        if(screenMode == Streaming_Client){
            [self.bottomView setHidden:NO];
            decoder.streamImageView = _imageView;
        }
        
        [self.bottomView setHidden:NO];
        [self.tabBarView setHidden:NO];
        [self.questionTableView setHidden:NO];
        
        [_btnFullScreenMode setImage:[UIImage imageNamed:@"icon_full_mode.png"] forState:UIControlStateNormal];
        [self.fullScreenView setHidden:YES];
    }
    
}

- (IBAction)btnUpFrontandBackCameraMode:(id)sender {
    isBackCamera = !isBackCamera;
    [self setupAVCapture];
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
-(void)captureOutput:(AVCaptureOutput *)captureOutput didDropSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection{
}

-(void)stateChanged:(id)sender state:(MPMediaStreamState)state description:(NSString *)description{
    switch (state) {
        case CONN_DISCONNECTED: {
            [self dismissViewControllerAnimated:YES completion:nil];
        }break;
        case CONN_CONNECTED: {
            [upstream start];
            [_loadingBar setHidden:YES];
            
        }break;
        case STREAM_CREATED: {
            if(screenMode == Streaming_Client){
                [decoder resume];
                [_loadingBar setHidden:YES];
            }
        }break;
            
        case STREAM_PLAYING: {
            if(screenMode == Streaming_Client){
//                if ([description isEqualToString:MP_RESOURCE_TEMPORARILY_UNAVAILABLE]) {
//                    SHOWALLERT(@"Warning", @"Temporarily unavailable");
//                    break;
//                }
//                
//                if ([description isEqualToString:MP_NETSTREAM_PLAY_STREAM_NOT_FOUND]) {
//                    
//                    break;
//                }
            }else if(screenMode == Streaming_Host){
                
            }
        }break;
            
        case STREAM_PAUSED:{
            if ([description isEqualToString:MP_RESOURCE_TEMPORARILY_UNAVAILABLE]) {
                SHOWALLERT(@"Warning", @"Temporarily unavailable");
                break;
            }
        }break;
        default:
            break;
    }
}

-(void)connectFailed:(id)sender code:(int)code description:(NSString *)description{
    NSLog(@"DetailViewController - Live connection failed");
    if (!upstream)
        return;
    
    [self setDisconnect];
    if(code == -7){
        if(screenMode == Streaming_Host){
            [self startLiveStreamingVideo];
        }else {
            [self doConnect];
        }
    }
}

@end


@implementation DetailViewController (CaptureProcessing)

-(void)setupAVCapture {
    
    // Create the session
    videoDataOutput = nil; session = nil;
    
    session = [AVCaptureSession new];
    [session setSessionPreset:[self captureSessionPreset]];
    
    // Select a video device, make an input
    NSError *error = nil;
    AVCaptureDevice *device = nil;
    if(isBackCamera == true){
        device= [self cameraWithPosition:AVCaptureDevicePositionBack];
    }else if(isBackCamera == false) {
        device = [self cameraWithPosition:AVCaptureDevicePositionFront];
    }
    
    if(device == nil) {
        device= [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (error) {
        NSLog(@" setupAVCapture - > ERROR: %@", [error localizedDescription]);
        session = nil;
        return;
    }
    
    if ([session canAddInput:deviceInput])
        [session addInput:deviceInput];
    
    // Make a video data output
    videoDataOutput = [AVCaptureVideoDataOutput new];
    NSDictionary *rgbOutputSettings = @{(id)kCVPixelBufferPixelFormatTypeKey:@(kCMPixelFormat_32BGRA)};
    [videoDataOutput setVideoSettings:rgbOutputSettings];
    [videoDataOutput setAlwaysDiscardsLateVideoFrames:YES]; // discard if the data output queue is blocked (as we process the still image)
    // Create a serial queue to handle the processing of our frames
    videoDataOutputQueue = dispatch_queue_create("com.themidnightcoders.RTMPPhotoPublisher", DISPATCH_QUEUE_SERIAL);
    [videoDataOutput setSampleBufferDelegate:self queue:videoDataOutputQueue];
    
    if ([session canAddOutput:videoDataOutput])
        [session addOutput:videoDataOutput];
    
    
    //on front camera flipped image is showed
    if(isBackCamera == false) {
        AVCaptureConnection *conn = [videoDataOutput connectionWithMediaType:AVMediaTypeVideo];
        [conn setVideoMirrored:true];
        [conn setVideoOrientation:AVCaptureVideoOrientationLandscapeRight];
    }
    
    [session commitConfiguration];
    
    [session startRunning];
}

// clean up capture setup
-(void)teardownAVCapture {
    
    if (upstream.state != CONN_CONNECTED)
        return;
    
    videoDataOutput = nil;
    
    session = nil;
}

-(NSString *)captureSessionPreset {
    
    switch (resolution) {
        case RESOLUTION_LOW:
            return AVCaptureSessionPresetLow;
        case RESOLUTION_CIF:
            return AVCaptureSessionPreset352x288;
        case RESOLUTION_MEDIUM:
            return AVCaptureSessionPresetMedium;
        case RESOLUTION_VGA:
            return AVCaptureSessionPreset640x480;
        case RESOLUTION_HIGH:
            return AVCaptureSessionPresetHigh;
        default:
            return AVCaptureSessionPresetLow;
    }
}

-(void)flushFrame {
    if (upstream && (upstream.state == STREAM_PLAYING)) {
        isPhotoPicking = YES;
        NSLog(@"flush Frame");
    }
}

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    
    for (AVCaptureDevice *device in devices)
    {
        if ([device position] == position)
            return device;
    }
    return nil;
}


#pragma mark -
#pragma mark AVCaptureVideoDataOutputSampleBufferDelegate Methods

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    
    if (!isPhotoPicking)
        return;
    
    
    CVPixelBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    int64_t _timestamp = [self getTimestampMs];
    
    CGImageRef frame = [self imageFromPixelBuffer:pixelBuffer];
    if(isCaptureScreen == true){
        [upstream sendImage:frame timestamp:_timestamp];
        [_player playImageBuffer:pixelBuffer];
        [fullplayer playImageBuffer:pixelBuffer];
        
    }
    CGImageRelease(frame);
    isPhotoPicking = NO;
}
@end

@implementation DetailViewController (ImageProcessing)

// !!! after using need !!! - CVPixelBufferRelease(pixelBuffer);
-(CVPixelBufferRef)pixelBufferFromCGImage:(CGImageRef)image {
    
    // config the options
    size_t width = CGImageGetWidth(image);
    size_t height = CGImageGetHeight(image);
    size_t bitsPerComponent = 8; // *not* CGImageGetBitsPerComponent(image);
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bi = kCGImageAlphaNoneSkipFirst | kCGBitmapByteOrder32Little; // *not* CGImageGetBitmapInfo(image);
    NSDictionary *options = @{(id)kCVPixelBufferCGImageCompatibilityKey:@YES, (id)kCVPixelBufferCGBitmapContextCompatibilityKey:@YES};
    
    // create pixel buffer
    CVPixelBufferRef pxbuffer = NULL;
    CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault, width, height, kCVPixelFormatType_32BGRA, (__bridge CFDictionaryRef)options, &pxbuffer);
    NSParameterAssert(status == kCVReturnSuccess && pxbuffer != NULL);
    
    CVPixelBufferLockBaseAddress(pxbuffer, 0);
    
    void *pxdata = CVPixelBufferGetBaseAddress(pxbuffer);
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(pxbuffer);
    
    CGContextRef context = CGBitmapContextCreate(pxdata, width, height, bitsPerComponent, bytesPerRow, cs, bi);
    if (context == NULL){
        [DebLog logY:@"pixelBufferFromCGImage: (ERROR) could not create context"];
    }
    else {
        CGContextDrawImage(context, CGRectMake(0, 0, width, height), image);
        CGContextRelease(context);
    }
    
    CVPixelBufferUnlockBaseAddress(pxbuffer, 0);
    
    CGColorSpaceRelease(cs);
    
    return pxbuffer;
}

// !!! after using need !!! - CGImageRelease(cgImage);
-(CGImageRef)imageFromPixelBuffer:(CVPixelBufferRef)frameBuffer {
    
    if (!frameBuffer)
        return nil;
    
    // Lock the image buffer
    CVPixelBufferLockBaseAddress(frameBuffer, 0);
    
    // Get the pixel buffer width and height.
    size_t width = CVPixelBufferGetWidth(frameBuffer);
    size_t height = CVPixelBufferGetHeight(frameBuffer);
    // Get the base address of the pixel buffer.
    uint8_t *frame = CVPixelBufferGetBaseAddress(frameBuffer);
    // Get the data size for contiguous planes of the pixel buffer.
    size_t bufferSize = CVPixelBufferGetDataSize(frameBuffer);
    // Get the device color space
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceRGB();
    // Bitmap options
    CGBitmapInfo bi = kCGImageAlphaNoneSkipFirst | kCGBitmapByteOrder32Little;
    
    // Create a Quartz direct-access data provider that uses data we supply.
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, frame, bufferSize, NULL);
    // Create a bitmap image from data supplied by the data provider.
    CGImageRef cgImage = CGImageCreate(width, height, 8, 32, bufferSize/height, cs, bi, dataProvider, NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    
    // Unlock the  image buffer
    CVPixelBufferUnlockBaseAddress(frameBuffer, 0);
    
    return cgImage;
}

@end
