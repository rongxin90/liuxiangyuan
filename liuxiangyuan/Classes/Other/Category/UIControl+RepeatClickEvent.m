//
//  UIControl+RepeatClickEvent.m
//  liuxiangyuan
//
//  Created by 桂荣信 on 2017/3/11.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "UIControl+RepeatClickEvent.h"
#import <objc/runtime.h>


@implementation UIControl (RepeatClickEvent)

static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";
static const char *UIControl_ignoreEvent = "UIControl_ignoreEvent";


- (NSTimeInterval)grx_acceptEventInterval{
    
    return [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}

- (void)setGrx_acceptEventInterval:(NSTimeInterval)grx_acceptEventInterval{
    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(grx_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)grx_ignoreEvent{
    return [objc_getAssociatedObject(self, UIControl_ignoreEvent) boolValue];
}

- (void)setGrx_ignoreEvent:(BOOL)grx_ignoreEvent{
    objc_setAssociatedObject(self, UIControl_ignoreEvent, @(grx_ignoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+(void)load{
    
    //获取系统的对象方法
    Method a = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    
    //获取自定义方法
    Method b = class_getInstanceMethod(self, @selector(grx_sendAction:to:forEvent:));
    
    //交换方法地址
    method_exchangeImplementations(a, b);
}

- (void)grx_sendAction:(SEL)selector to:(id)target forEvent:(UIEvent *)event{
    if (self.grx_ignoreEvent) return;
    
    if (self.grx_acceptEventInterval > 0) {
        self.grx_ignoreEvent = YES;
        [self performSelector:@selector(setGrx_ignoreEvent:) withObject:@(NO) afterDelay:self.grx_acceptEventInterval];
    }
    
    [self grx_sendAction:selector to:target forEvent:event];
    
}

@end
