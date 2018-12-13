//
//  GRXHomeFocusCollectionCell.m
//  liuxiangyuan
//
//  Created by 桂荣信 on 2017/3/13.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "GRXHomeFocusCollectionCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "GRXFocusModel.h"
@implementation GRXHomeFocusCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

- (void)setModel:(GRXFocusModel *)model{
    _model = model;
    
    
    NSString *str = @"http://newimg.4001113900.com/";
    
    NSString *urlString = [str stringByAppendingPathComponent:model.newsUrl];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
//    NSLog(@"%@",model.newsUrl);
    
//    [self upda]
    
    //给子控件赋值
    [self.imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Headline_View_Placehold~iphone"]];
    
    
}



- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
}

@end
