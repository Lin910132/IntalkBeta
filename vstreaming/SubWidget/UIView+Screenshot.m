//
//  UIView+Screenshot.m
//  MediaLibDemos
//
//  Created by user1 on 7/9/16.
//  Copyright © 2016 The Midnight Coders, Inc. All rights reserved.
//

#import "UIView+Screenshot.h"

@interface UIView (screen)
@end

@implementation UIView (screen)
-(UIImage *)convertViewToImage
{
    UIGraphicsBeginImageContext(self.frame.size);
//    [self drawViewHierarchyInRect:self.frame afterScreenUpdates:YES];
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
