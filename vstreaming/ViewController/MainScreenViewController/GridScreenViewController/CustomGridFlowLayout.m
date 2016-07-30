//
//  CustomGridFlowLayout.m
//  vstreaming
//
//  Created by developer on 7/24/16.
//  Copyright © 2016 ITGroup. All rights reserved.
//

#import "CustomGridFlowLayout.h"

@implementation CustomGridFlowLayout
-(instancetype)init{
    self = [super init];
    if (self){
        self.minimumLineSpacing = 1.0;
        self.minimumInteritemSpacing = 1.0;
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return self;
}

-(CGSize)itemSize{
    NSInteger numberOfColumns = 2;
    CGFloat itemWidth = (CGRectGetWidth(self.collectionView.frame) - (numberOfColumns - 1)) / numberOfColumns;
    return CGSizeMake(itemWidth, itemWidth);
}

@end
