//
//  UIBarButtonItem+item.h
//  liuxiangyuan
//
//  Created by 桂荣信 on 2017/3/12.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (item)


+ (UIBarButtonItem *)itemWithNorImage:(UIImage *)image highImage:(UIImage *)highImage target:(nullable id)target action:(nullable SEL)action;


+ (UIBarButtonItem *)itemWithNorImage:(UIImage *)image selImage:(UIImage *)highImage target:(nullable id)target action:(nullable SEL)action;


+ (UIBarButtonItem *)itemWithNorImage:(UIImage *)image selImage:(UIImage *)highImage target:(nullable id)target action:(nullable SEL)action norColor:(UIColor *)norColor highColor:(UIColor *)highColor title:(NSString *)title;

@end
