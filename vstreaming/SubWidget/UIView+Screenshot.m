//
//  UIView+Screenshot.m
//  MediaLibDemos
//
//  Created by user1 on 7/9/16.
//  Copyright © 2016 The Midnight Coders, Inc. All rights reserved.
//

#import "UIView+Screenshot.h"

@interface UIView(screen)
@end

@implementation UIView (screen)
-(UIImageView *)convertViewToImage
{
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImageView *image = [UIImageView alloc];
    image.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:image];
    return image;
}
@end
