//
//  GRXTabbarItem.m
//  liuxiangyuan
//
//  Created by 桂荣信 on 2017/3/15.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "GRXTabbarItem.h"
#import "UIView+Frame.h"

@implementation GRXTabbarItem
// 不需要系统提供的高亮样式
- (void)setHighlighted:(BOOL)highlighted{
    //    [super setHighlighted:highlighted];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect imageViewFrame = self.imageView.frame;
    imageViewFrame.origin.y = 5;
    self.imageView.frame = imageViewFrame;
    
    CGPoint imageViewCenter = self.imageView.center;
    imageViewCenter.x = self.bounds.size.width * 0.5;
    self.imageView.center = imageViewCenter;
    
    CGRect titleLabelFrame = self.titleLabel.frame;
    titleLabelFrame.origin.y = self.imageView.bounds.size.height + 5;
    titleLabelFrame.size.width = self.bounds.size.width;
    self.titleLabel.frame = titleLabelFrame;
    
    CGPoint titleLabelCenter = self.titleLabel.center;
    titleLabelCenter.x = self.imageView.center.x;
    self.titleLabel.center = titleLabelCenter;
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    

    
    
    
//    CGRect titleLabelFrame = self.titleLabel.frame;
//    titleLabelF
    
    
}

@end
