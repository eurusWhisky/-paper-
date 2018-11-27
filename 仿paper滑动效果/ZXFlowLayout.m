//
//  ZXFlowLayout.m
//  仿paper滑动效果
//
//  Created by 陈伟杰 on 2018/11/27.
//  Copyright © 2018年 陈伟杰. All rights reserved.
//

#import "ZXFlowLayout.h"

@implementation ZXFlowLayout
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)prepareLayout{
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.itemSize = CGSizeMake(KMAINWIDTH/2, 300);
    self.minimumInteritemSpacing = 0.0;
    self.minimumLineSpacing = 0.0;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *arrayAttrs = [[NSArray alloc] initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];
    
    CGFloat centerX = self.collectionView.contentOffset.x +self.collectionView.bounds.size.width*0.5;
    
    for (UICollectionViewLayoutAttributes *attr in arrayAttrs) {
        
        CGFloat distance = ABS(attr.center.x-centerX);
        CGFloat factor = 0.001;
        CGFloat scale = 1/(1+distance*factor);
        attr.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return arrayAttrs;
}
@end
