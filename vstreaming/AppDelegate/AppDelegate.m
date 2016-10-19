//
//  AppDelegate.m
//  vstreaming
//
//  Created by developer on 7/22/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "AppDelegate.h"
#import "WechatAccess.h"
#import "TencentAccess.h"
#import "WeiboAccess.h"
#import <AVFoundation/AVFoundation.h>
#import "IQKeyboardManager.h"
#import "SAMHUDView.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
@interface AppDelegate (){
    UIActivityIndicatorView *_loader;
    UIImageView *_loaderBackgroundView;
    SAMHUDView *samhudView;
}
@end

@implementation AppDelegate

static NSString *const kWeChatScheme = @"wx12ac7e69090902cd";
static NSString *const kWeiboScheme = @"wb2207922663";
static NSString *const kTencentScheme = @"tencent1105461365";


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //for streaming capture and playing.
    [Fabric with:@[[Crashlytics class]]];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:20];
    [[IQKeyboardManager sharedManager] setShouldShowTextFieldPlaceholder:YES];
    
    
    [WechatAccess registerApp];
    [WeiboAccess registerApp];
#ifdef DEBUG
    [WeiboAccess enableDebugMode:YES];
#endif
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    // WeChat
    if ([url.scheme isEqualToString:kWeChatScheme]) {
        return [WechatAccess handleOpenURL:url];
    }
    // QQ
    else if ([url.scheme isEqualToString:kTencentScheme]) {
        return [TencentAccess HandleOpenURL:url];
    }
    // WeiBo
    else if ([url.scheme isEqualToString:kWeiboScheme]) {
        return [WeiboAccess handleOpenURL:url];
    }
    else
        return false;
    
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    // WeChat
    if ([url.scheme isEqualToString:kWeChatScheme]) {
        return [self application:application handleOpenURL:url];
    }
    // QQ
    else if ([url.scheme isEqualToString:kTencentScheme]) {
        return [TencentAccess HandleOpenURL:url];
    }
    // WeiBo
    else if ([url.scheme isEqualToString:kWeiboScheme]) {
        return [WeiboAccess handleOpenURL:url];
    }
    else
        return false;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.itgroup.vstreaming" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"vstreaming" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"vstreaming.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - WeiXin

//-(void) onReq:(BaseReq*)req
//{
//    if([req isKindOfClass:[GetMessageFromWXReq class]])
//    {
//        // 微信请求App提供内容， 需要app提供内容后使用sendRsp返回
//        NSString *strTitle = [NSString stringWithFormat:@"微信请求App提供内容"];
//        NSString *strMsg = @"微信请求App提供内容，App要调用sendResp:GetMessageFromWXResp返回给微信";
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        alert.tag = 1000;
//        [alert show];
////        [alert release];
//    }
//    else if([req isKindOfClass:[ShowMessageFromWXReq class]])
//    {
//        ShowMessageFromWXReq* temp = (ShowMessageFromWXReq*)req;
//        WXMediaMessage *msg = temp.message;
//        
//        //显示微信传过来的内容
//        WXAppExtendObject *obj = msg.mediaObject;
//        
//        NSString *strTitle = [NSString stringWithFormat:@"微信请求App显示内容"];
//        NSString *strMsg = [NSString stringWithFormat:@"标题：%@ \n内容：%@ \n附带信息：%@ \n缩略图:%u bytes\n\n", msg.title, msg.description, obj.extInfo, msg.thumbData.length];
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
////        [alert release];
//    }
//    else if([req isKindOfClass:[LaunchFromWXReq class]])
//    {
//        //从微信启动App
//        NSString *strTitle = [NSString stringWithFormat:@"从微信启动"];
//        NSString *strMsg = @"这是从微信启动的消息";
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
////        [alert release];
//    }
//}
//
//-(void) onResp:(BaseResp*)resp
//{
//    if([resp isKindOfClass:[SendMessageToWXResp class]])
//    {
//        NSString *strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
//        NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
////        [alert release];
//    }
//}

#pragma mark - Live Streaming
- (void)showLoader {
    if (_loader == nil) {
        _loader = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _loaderBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loader_background"]];
        [self.window addSubview:_loaderBackgroundView];
        _loader.frame = CGRectMake(_loaderBackgroundView.center.x - (_loader.frame.size.width / 2),
                                   _loaderBackgroundView.center.y - (_loader.frame.size.height / 2),
                                   _loader.frame.size.width,
                                   _loader.frame.size.height);
        [_loaderBackgroundView addSubview:_loader];
    } else {
        [_loader setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    }
    [self centerLoader];
    [self.window bringSubviewToFront:_loaderBackgroundView];
    _loaderBackgroundView.hidden = NO;
    [_loader startAnimating];
    [self.window setUserInteractionEnabled:NO];
}

- (void)showBlackLoader {
    if (_loader == nil) {
        _loader = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _loaderBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loader_background"]];
        [self.window addSubview:_loaderBackgroundView];
        _loader.frame = CGRectMake(_loaderBackgroundView.center.x - (_loader.frame.size.width / 2),
                                   _loaderBackgroundView.center.y - (_loader.frame.size.height / 2),
                                   _loader.frame.size.width,
                                   _loader.frame.size.height);
        [_loaderBackgroundView addSubview:_loader];
    }else{
        [_loader setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    }
    
    [self centerLoader];
    [self.window bringSubviewToFront:_loaderBackgroundView];
    _loaderBackgroundView.hidden = NO;
    [_loader startAnimating];
    [self.window setUserInteractionEnabled:NO];
}

- (void)hideLoader {
    if(_loader != nil) {
        [self.window setUserInteractionEnabled:YES];
        [_loader stopAnimating];
        _loaderBackgroundView.hidden = YES;
    }
    
    if(samhudView != nil){
        [samhudView dismiss];
    }
}
- (void)centerLoader {
    _loaderBackgroundView.frame = CGRectMake(self.window.center.x - (_loaderBackgroundView.frame.size.width / 2),
                                             self.window.center.y - (_loaderBackgroundView.frame.size.height / 2),
                                             _loaderBackgroundView.frame.size.width,
                                             _loaderBackgroundView.frame.size.height);
}

-(void)showLoaderWithString:(NSString *)loadingString{
    if(samhudView == nil){
        samhudView = [[SAMHUDView alloc] initWithTitle:NSLocalizedString(loadingString, nil)];
    }else{
        samhudView.textLabel.text = loadingString;
    }
    [samhudView show];
}

-(void)uploadingViewinBackground:(NSString *)token video:(NSString *)video broadcastID:(int)broadcastID{
    [InTalkAPI stopBroadCasting:[[User getInstance] getUserToken] broadcastID:broadcastID Video:nil block:^(NSDictionary *json, NSError *error) {
        if(!error){
            
        }else{
            NSLog(@"%@", error);
        }
    }];
}
@end
