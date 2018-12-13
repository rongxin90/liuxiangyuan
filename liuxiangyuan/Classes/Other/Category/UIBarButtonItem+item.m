//
//  UIBarButtonItem+item.m
//  liuxiangyuan
//
//  Created by 桂荣信 on 2017/3/12.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "UIBarButtonItem+item.h"

@implementation UIBarButtonItem (item)

+(UIBarButtonItem *)itemWithNorImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action{
    
    UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
    [item setImage:image forState:UIControlStateNormal];
    [item setImage:highImage forState:UIControlStateHighlighted];
    
    //根据内容自适应尺寸
    [item sizeToFit];
    
    [item addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    
    
    return [[UIBarButtonItem alloc] initWithCustomView:item];
}


+(UIBarButtonItem *)itemWithNorImage:(UIImage *)image selImage:(UIImage *)highImage target:(id)target action:(SEL)action{
    
    UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
    [item setImage:image forState:UIControlStateNormal];
    [item setImage:highImage forState:UIControlStateSelected];
    
    //根据内容自适应尺寸
    [item sizeToFit];
    
    [item addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    
    
    return [[UIBarButtonItem alloc] initWithCustomView:item];
}



+ (UIBarButtonItem *)itemWithNorImage:(UIImage *)image selImage:(UIImage *)highImage target:(id)target action:(SEL)action norColor:(UIColor *)norColor highColor:(UIColor *)highColor title:(NSString *)title{
    
    UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
    [item setImage:image forState:UIControlStateNormal];
    [item setImage:highImage forState:UIControlStateHighlighted];
    
    
    [item setTitle:title forState:UIControlStateNormal];
    
    
    
    [item addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [item setTitleColor:norColor forState:UIControlStateNormal];
    [item setTitleColor:highColor forState:UIControlStateHighlighted];
    
    
    //根据内容自适应尺寸
    [item sizeToFit];
    
    
    [item addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:item];
    
}


@end
