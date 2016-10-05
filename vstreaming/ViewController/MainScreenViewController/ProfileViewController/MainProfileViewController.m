//
//  MainProfileViewController.m
//  vstreaming
//
//  Created by developer on 7/25/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "MainProfileViewController.h"
#import "FollowInformationViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface MainProfileViewController() <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    BOOL isImageUploading;
}
@end

@implementation MainProfileViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self showMyInfo];
    [self initUI];
}

#pragma mark - Outlets
- (IBAction)btnFollowerClicked:(id)sender {
    FollowInformationViewController *followInfoVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"FollowInformationViewController"];
    [self presentViewController:followInfoVC animated:YES completion:nil];
}

- (IBAction)btnFollowingClicked:(id)sender {
    FollowInformationViewController *followInfoVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"FollowInformationViewController"];
    [self presentViewController:followInfoVC animated:YES completion:nil];
}

#pragma mark - Private
-(void) showMyInfo{
    User* currentUser = [User getInstance];
    self.userID.text = [NSString stringWithFormat:@"ID: %d", currentUser.user_id];
    self.userName.text = currentUser.name;
    
}

-(void) initUI{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(didTapUserLogoImgView)];
    [self.userLogo addGestureRecognizer:tap];
}

-(void) didTapUserLogoImgView{
    if(isImageUploading){
        return;
    }
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.allowsEditing = YES;
    pickerController.delegate = self;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Please choose an option" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    alertController.view.tintColor = greenColorForButtons;
    UIAlertAction *chooseLibrary = [UIAlertAction actionWithTitle:@"Photo Libriary" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:pickerController animated:YES completion:nil];
    }];
    UIAlertAction *chooseCamera = [UIAlertAction actionWithTitle:@"Use Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        pickerController.mediaTypes= [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        if (authStatus == AVAuthorizationStatusAuthorized)
        {
            [self presentViewController:pickerController animated:YES completion:nil];
        }
        else if (authStatus == AVAuthorizationStatusNotDetermined)
        {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted)
             {
                 if(granted)
                 {
                     NSLog(@"Granted access to %@", AVMediaTypeVideo);
                     [self presentViewController:pickerController animated:YES completion:nil];
                 }
             }];
        }
        else if(authStatus == AVAuthorizationStatusDenied || authStatus == AVAuthorizationStatusRestricted)
        {
            UIAlertController *cameraController = [UIAlertController alertControllerWithTitle:@"Camera access denied" message:@"Please change privacy settings" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *sendAction = [UIAlertAction actionWithTitle:@"Change Settings" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                         {
                                             [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                                         }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
            [cameraController addAction:sendAction];
            [cameraController addAction:cancel];
            cameraController.view.tintColor = greenColorForButtons;
            [self presentViewController:cameraController animated:YES completion:nil];
        }
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [alertController addAction:chooseCamera];
    }
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        [alertController addAction:chooseLibrary];
    }
    [alertController addAction:cancelAction];
    [alertController setModalPresentationStyle:UIModalPresentationPopover];
    UIPopoverPresentationController *popPresenter = [alertController
                                                     popoverPresentationController];
    
    CGRect rect = CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/2, 1, 1);
    [popPresenter setPermittedArrowDirections:0];
    popPresenter.sourceRect = rect;
    popPresenter.sourceView = self.view;
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
