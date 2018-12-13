//
//  GRXImageCollectionCell.m
//  liuxiangyuan
//
//  Created by 桂荣信 on 2017/3/14.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "GRXImageCollectionCell.h"
//#import <UIImageView+WebCache.h>
@implementation GRXImageCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.contentView.backgroundColor = [UIColor redColor];
        [self setUpImageView];
    }
    return self;
}



- (void)setUpImageView{
    self.iamgeView = [[UIImageView alloc] init];
    self.iamgeView.userInteractionEnabled = NO;
//    self.iamgeView.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:self.iamgeView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.iamgeView.frame = self.bounds;
}

@end
