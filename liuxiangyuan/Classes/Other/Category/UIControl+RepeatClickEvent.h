//
//  UIControl+RepeatClickEvent.h
//  liuxiangyuan
//
//  Created by 桂荣信 on 2017/3/11.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (RepeatClickEvent)

//再次处理事件的时间
@property (assign, nonatomic) NSTimeInterval grx_acceptEventInterval;


//是否忽略事件
@property (assign, nonatomic) BOOL grx_ignoreEvent;

@end
