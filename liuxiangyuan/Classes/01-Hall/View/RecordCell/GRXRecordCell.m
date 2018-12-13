//
//  GRXRecordCell.m
//  liuxiangyuan
//
//  Created by 桂荣信 on 2017/3/14.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "GRXRecordCell.h"
#import "GRXContentCell.h"

static NSString *idfinerID = @"idfinerID";

@interface GRXRecordCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

{
    UIView *_separateView;
    UIButton *_titleButton;
    UICollectionViewFlowLayout *_flowLayout;
    UICollectionView *_collectionView;
}

@property (strong, nonatomic) NSArray *imageNames;


@end

@implementation GRXRecordCell

- (NSArray *)imageNames
{
    if (!_imageNames) {
        _imageNames = @[@"icon_growUp_explain~iphone",
                        @"icon_growUp_schedule~iphone",
                        @"icon_growUp_mating~iphone",
                        @"icon_growUp_modelHouse~iphone",
                        @"icon_growUp_audio~iphone",
                        @"icon_growUp_sale~iphone",
                        @"icon_growUp_event~iphone",
                        ];
    }
    return _imageNames;
}

- (NSArray *)title{
    
    if (!_title) {
        _title = @[@"留香解读",
                   @"留香进度",
                   @"小区配套",
                   @"样板房",
                   @"留香影像",
                   @"销售情况",
                   @"大事记",                   
                   ];
    }
    return _title;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews{
    //设置头标题
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleButton setTitle:@"成长记" forState:UIControlStateNormal];
    titleButton.titleLabel.font = [UIFont systemFontOfSize:13];
    titleButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [titleButton.imageView setContentMode:UIViewContentModeScaleAspectFill];
    [titleButton setImage:[UIImage imageNamed:@"icon_butterfly~iphone"] forState:UIControlStateNormal];
    titleButton.enabled = NO;
    [titleButton sizeToFit];
//    [btn]
    _titleButton = titleButton;
    [self.contentView addSubview:titleButton];
    
    //设置分割线
    UIView *separateView = [[UIView alloc] init];
    separateView.backgroundColor = [UIColor lightGrayColor];
    _separateView = separateView;
    [self.contentView addSubview:separateView];
    
    //设置子标题选项卡
    //创建一个流水布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(self.bounds.size.width / 6.0, self.bounds.size.height - 30);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 2;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout = flowLayout;
    
    //创建一个UICollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.backgroundColor = self.backgroundColor;
    collectionView.bounces = NO;
    [self.contentView addSubview:collectionView];
    
    //注册cell
    [collectionView registerClass:[GRXContentCell class] forCellWithReuseIdentifier:idfinerID];
    _collectionView = collectionView;

}
- (void)layoutSubviews{
    [super layoutSubviews];
//    _separateView.frame = self.bounds;
//    CGFloat width = [_titleButton siz];
    
    _flowLayout.itemSize = CGSizeMake(self.bounds.size.width / 6.0, self.bounds.size.height - 30);
    _titleButton.frame = CGRectMake(-20, 5, 100, 20);
    _separateView.frame = CGRectMake(0, 30, self.bounds.size.width, 1);
    _collectionView.frame = CGRectMake(0, _separateView.frame.origin.y + _separateView.bounds.size.height, self.bounds.size.width, self.bounds.size.height - 30);
}

#pragma mark - CollectionView的数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.title.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GRXContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:idfinerID forIndexPath:indexPath];
    [cell.contentButton setTitle:self.title[indexPath.row] forState:UIControlStateNormal];
    [cell.contentButton setImage:[UIImage imageNamed:self.imageNames[indexPath.row]] forState:UIControlStateNormal];
    cell.contentButton.tag = indexPath.item;
//    cell.contentView.backgroundColor = randomColor;
    return cell;
}

#pragma mark - CollectionView的打理方法
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
