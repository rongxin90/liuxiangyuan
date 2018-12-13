//
//  GRXButton.m
//  liuxiangyuan
//
//  Created by 桂荣信 on 2017/3/12.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "GRXButton.h"

@implementation GRXButton

//调整item内部子控件的位置
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect imageViewFrame = self.imageView.frame;
    imageViewFrame.origin.y = 5;
    imageViewFrame.size.width = 50;
    imageViewFrame.size.height = 50;
    self.imageView.frame = imageViewFrame;
    
    CGPoint imageViewCenter = self.imageView.center;
    imageViewCenter.x = self.bounds.size.width * 0.5;
    self.imageView.center = imageViewCenter;
    
    CGRect titleLabelFrame = self.titleLabel.frame;
    titleLabelFrame.origin.y = self.imageView.bounds.size.height + 10;
    titleLabelFrame.size.width = self.bounds.size.width;
    self.titleLabel.frame = titleLabelFrame;
    
    CGPoint titleLabelCenter = self.titleLabel.center;
    titleLabelCenter.x = self.imageView.center.x;
    self.titleLabel.center = titleLabelCenter;
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}
@end
