//
//  ViewController.m
//  仿paper滑动效果
//
//  Created by 陈伟杰 on 2018/11/27.
//  Copyright © 2018年 陈伟杰. All rights reserved.
//

#import "ViewController.h"
#import "ZXFlowLayout.h"
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)ZXFlowLayout *layout;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0];
    [self.view addSubview:self.collectionView];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds byRoundingCorners:UIRectCornerBottomRight|UIRectCornerTopRight cornerRadii:CGSizeMake(25, 25)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = cell.bounds;
    maskLayer.path = maskPath.CGPath;
    cell.layer.mask = maskLayer;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 5, 300)];
    view.backgroundColor = [UIColor blackColor];
    [cell addSubview:view];
    return cell;
}


//手离开屏幕时
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if (scrollView.contentOffset.x<0) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }else{
        NSInteger i = scrollView.contentOffset.x/(KMAINWIDTH/2);
        [self.collectionView setContentOffset:CGPointMake((i+1)*KMAINWIDTH/2-KMAINWIDTH/4, self.collectionView.contentOffset.y) animated:YES];
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}




-(UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-200) collectionViewLayout:self.layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
        //        _collectionView.pagingEnabled = YES;
        _collectionView.contentInset = UIEdgeInsetsMake(0, KMAINWIDTH/4, 0, KMAINWIDTH/4);
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return _collectionView;
}

-(ZXFlowLayout *)layout{
    if (!_layout) {
        _layout = [[ZXFlowLayout alloc] init];
    }
    return _layout;
}

@end
