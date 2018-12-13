//
//  GRXCarouselImageView.m
//  liuxiangyuan
//
//  Created by 桂荣信 on 2017/3/17.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "GRXCarouselImageView.h"
#import "GRXHomeFocusCollectionCell.h"

// 通过RGB创建UIColor
#define RGB(R,G,B) [UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:1]


static NSString *idfinerID = @"idfinerID";
// 定义cell放大倍数
static NSInteger const kEnLargerFactor = 50;
@interface GRXCarouselImageView ()<UICollectionViewDelegate,UICollectionViewDataSource>

{
    UICollectionView *_collectionView;
    UICollectionViewFlowLayout *_flowLayout;
    UIPageControl *_pageControl;
    NSTimer *_timer;
//    NSArray *_imageNames;
}

@end


@implementation GRXCarouselImageView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpCollectionView];
    }
    return self;
}

- (void)setUpCollectionView{
    //创建一个流水布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = self.bounds.size;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout = flowLayout;
    
    //创建一个UICollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor redColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    [self addSubview:collectionView];
    
    //注册cell
    [collectionView registerClass:[GRXHomeFocusCollectionCell class] forCellWithReuseIdentifier:idfinerID];
    _collectionView = collectionView;
    
    //创建指示器
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageControl.pageIndicatorTintColor = [UIColor blueColor];
    [self addSubview:pageControl];
    _pageControl = pageControl;
}



- (void)layoutSubviews{
    [super layoutSubviews];
    
    //重新调整集合视图的大小
    _collectionView.frame = self.bounds;
    _flowLayout.itemSize = self.bounds.size;
    
    //调整指示器的位置
    _pageControl.center = CGPointMake(self.frame.size.width/2, self.frame.size.height - 20);
    if (_collectionView.contentOffset.x == 0) {
        //collectionView滚动到最中间位置
        NSInteger middleIndex = (4 * kEnLargerFactor) / 2;
        
        //滚回到第0个cell
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:middleIndex inSection:0];
        //滚动到中间
        [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}



- (void)setImagesArray:(NSArray *)imagesArray{
    _imagesArray = imagesArray;
    //设置一个定时器
    [self setUpTimer];
    
    
    //设置页面指示器的总页面
    _pageControl.numberOfPages = self.imagesArray.count;
}
#pragma mark - CollectionView的数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
//    NSLog(@"numberOfItemsInSection--%ld",self.imagesArray.count);
    return 4 * kEnLargerFactor;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GRXHomeFocusCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:idfinerID forIndexPath:indexPath];
    //对应cell显示的图片在self.imagesArray的位置
    NSInteger index = indexPath.item % 4;
//    NSLog(@"cellForItemAtIndexPath++%ld",self.imagesArray.count);
    GRXFocusModel *model = self.imagesArray[index];
    cell.model = model;
//    NSString *imageName = self.imagesArray[index];
//    cell.imageView.image = [UIImage imageNamed:imageName];
    return cell;
}

#pragma mark - CollectionView的代理方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //确定点击的是第几张图片
    NSInteger tag = indexPath.item % self.imagesArray.count;
//    NSLog(@"didSelectItemAtIndexPath++%ld",self.imagesArray.count);
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    if ([self.delegate respondsToSelector:@selector(grx_carouselImageClickTag:)]) {
        [self.delegate grx_carouselImageClickTag:tag];
    }
    
}

#pragma mark - scrollView的delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 当前显示的是第多少个cell
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    // cell显示的是第几张图片
//    NSLog(@"scrollViewDidScroll%ld",self.imagesArray.count);
    NSInteger page = index%4;
    
    _pageControl.currentPage = page;
}
// 用户拖拽scrollView,会调用这个方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 停止定时器
    [_timer invalidate];
    _timer = nil;
}
// 用户停止拖拽scrollView,会调用这个方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 重新开启一个定时器
    [self setUpTimer];
}
#pragma mark - 定时器监听方法
- (void)startAutoScroll
{
    /*
     思路
     1.获取collectionView当前显示的是哪一个cell
     2.滚动到下一个cell
     3.判断是否滚动到最后一个cell,如果滚动到了最后一个cell,下次滚回第一个cell
     */
    // 集合视图滚动到了哪一个cell
    NSInteger index = _collectionView.contentOffset.x/_collectionView.frame.size.width;
    index++;
    
    
    if (self.imagesArray.count * kEnLargerFactor == index) {
        // 滚回第0个cell
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
        // 滚动到下一张
        [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }else{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
        // 滚动到下一张
        [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }
}
// 创建一个定时器
- (void)setUpTimer
{
    [_timer invalidate];
    _timer = nil;
    
    // 创建一个定时器
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(startAutoScroll) userInfo:nil repeats:YES];
    // 开启定时器
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    _timer = timer;
}
// 创建随机背景色
- (UIColor *)randomColor
{
    NSInteger r = arc4random_uniform(255);
    NSInteger g = arc4random_uniform(255);
    NSInteger b = arc4random_uniform(255);
    
    return RGB(r, g, b);
}


@end

