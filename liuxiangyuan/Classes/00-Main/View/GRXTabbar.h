//
//  GRXTabbar.h
//  liuxiangyuan
//
//  Created by 桂荣信 on 2017/3/15.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>


//类的声明，仅强调文件中存在该类
@class GRXTabbar;
@protocol GRXTabbarDelegate<NSObject>
@optional
- (void)grx_bar:(GRXTabbar *)bar ClickAtIndexFrom:(NSInteger)from To:(NSInteger)index;
@end




@interface GRXTabbar : UIView

// 添加自定义的tabbarItem
-(void)addtabbarItemWithNormalImage:(NSString *)norImage andSelectedImage:(NSString *)selImage WithTitle:(NSString *)title;
@property (nonatomic, weak) id<GRXTabbarDelegate>delegate;

@end


