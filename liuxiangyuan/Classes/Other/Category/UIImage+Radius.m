//
//  UIImage+Radius.m
//  liuxiangyuan
//
//  Created by 桂荣信 on 2018/11/10.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "UIImage+Radius.h"

@implementation UIImage (Radius)

//设置裁剪图片(传入一张图片，返回一张裁剪成圆形的图片)


+ (UIImage *)setCornerRadius:(UIImage *)image{
    //获取图形上下文
    UIGraphicsBeginImageContext(image.size);
    
    //设置园型路径
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.width)];
    
    //把路径设置裁剪区
    [path addClip];
    
    //绘制图片
    [image drawAtPoint:CGPointMake(0, 0)];
    
    //从上下文中获取图片
    UIImage *rolImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return rolImage;
}

+ (UIImage *)grx_radiusWithImage:(UIImage *)image{
    UIImage *newImage = [self setCornerRadius:image];
    return newImage;
    
}



@end
