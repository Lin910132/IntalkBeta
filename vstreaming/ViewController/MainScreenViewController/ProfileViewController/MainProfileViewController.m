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
@property (nonatomic, strong) dispatch_group_t dispatchGroup;

@end

@implementation MainProfileViewController
#pragma mark - Lazy Loading

- (dispatch_group_t)dispatchGroup
{
    if(!_dispatchGroup)
    {
        _dispatchGroup = dispatch_group_create();
    }
    
    return _dispatchGroup;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self getMyInfo];
    [self showMyInfo];
    [self initUI];
}

#pragma mark - Outlets
- (IBAction)btnFollowerClicked:(id)sender {
    FollowInformationViewController *followInfoVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"FollowInformationViewController"];
    [followInfoVC setScreenType:Follower_Screen];
    [self presentViewController:followInfoVC animated:YES completion:nil];
}

- (IBAction)btnFollowingClicked:(id)sender {
    FollowInformationViewController *followInfoVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"FollowInformationViewController"];
    [followInfoVC setScreenType:Following_Screen];
    [self presentViewController:followInfoVC animated:YES completion:nil];
}

#pragma mark - Private
-(void) getMyInfo{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] showLoaderWithString:@"Loading..."];
    
    [InTalkAPI getMyInfoByToken:[[User getInstance] getUserToken] competion:^(NSDictionary * res, NSError * err) {
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] hideLoader];
        if(err == nil) {
            [[User getInstance] parseDataFromJson:res];
            [self showMyInfo];
        }else{
            NSLog(@"\n ---Get MyInfo API returns Such Error : \n --- %@", err);
        }
    }];
}

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
    [self.userLogo setUserInteractionEnabled:YES];
    [self.userLogo layoutIfNeeded];
    self.userLogo.layer.cornerRadius = self.userLogo.frame.size.height / 2;
    NSLog(@"%f", self.userLogo.frame.size.height);
    self.userLogo.layer.masksToBounds = YES;
    
    
}

-(void) uploadImage:(UIImage *) chosenImage{
    isImageUploading = YES;
    [self.userLogo setImage:chosenImage];
    __weak typeof(self) weakSelf = self;
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] showLoaderWithString:@"Uploading Image..."];
    dispatch_group_enter(self.dispatchGroup);
    NSString *base64Image = (NSString *)[UIImagePNGRepresentation(chosenImage) base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *base64StrParam = [NSString stringWithFormat:@"data:image/png;base64,%@", base64Image];
    [InTalkAPI setAvatarImage:[[User getInstance] getUserToken] imageData:base64StrParam competion:^(NSDictionary *resp, NSError *err) {
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] hideLoader];
        if(!err){
            NSLog(@"%@", resp);
        }else{
            NSLog(@"\n --- Set Avatar API occures such error: %@", err);
        }
        isImageUploading = NO;
        dispatch_group_leave(weakSelf.dispatchGroup);
    }];
    
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

#pragma mark - UIImagePickerControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    if (chosenImage)
    {
        [self uploadImage:chosenImage];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
