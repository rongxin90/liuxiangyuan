//
//  iconCell.m
//  liuxiangyuan
//
//  Created by 桂荣信 on 2018/11/10.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "iconCell.h"
#import "UIView+Frame.h"
#import <UIImageView+WebCache.h>
#import <Masonry.h>
#import "mineViewItem.h"
#import "UIImage+Radius.h"
@implementation iconCell


- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.x = 20;
    self.imageView.height = 80;
    self.imageView.width = 80;
    self.imageView.centerY = self.contentView.centerY;
    //查看缓存中是否有图片
//    //将选择的图片显示出来
//                NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/currentImage.png"];
                //从沙盒获取图片
                UIImage *image = [UIImage imageWithContentsOfFile:self.item.iconName];
                //设置圆角图片
                image = [UIImage grx_radiusWithImage:image];
                //        self.iconImageView.image = erd;
            //    NSLog(@"+++erd==%@",erd);
                if (image) {
                    self.imageView.image = image;
                }else{
                   UIImage *image = [UIImage grx_radiusWithImage:[UIImage imageNamed:@"icon"]];
                    self.imageView.image = image;
                }
}






@end
