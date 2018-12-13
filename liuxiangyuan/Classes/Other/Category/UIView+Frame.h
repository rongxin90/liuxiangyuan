//
//  UIView+Frame.h
//  ZS_OC
//
//  Created by funeral on 16/8/16.
//  Copyright (c) 2016年 funeral. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

// 分类中的property指的是方法的声明
@property (assign, nonatomic) CGFloat width; /**< 宽度 */
@property (assign, nonatomic) CGFloat height; /**< 高度 */
@property (assign, nonatomic) CGFloat x; /**< frameX */
@property (assign, nonatomic) CGFloat y; /**< frameY */
@property (assign, nonatomic) CGFloat centerX; /**< 中心点X */
@property (assign, nonatomic) CGFloat centerY; /**< 中心点Y */

//@property (nonatomic,assign)CGPoint origin;



@end
