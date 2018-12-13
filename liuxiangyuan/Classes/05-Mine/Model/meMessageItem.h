//
//  meMessageItem.h
//  liuxiangyuan
//
//  Created by 桂荣信 on 2018/11/5.
//  Copyright © 2018年 grx. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef enum{
    meMessageCellTypeNone,
    meMessageCellTypeArrow,
    meMessageCellTypeIcon,
    meMessageCellTypeLabel
    
} meMessageCellType;

@interface meMessageItem : NSObject
   
    //主标题
@property (copy, nonatomic) NSString *title;

    //右边显示什么图片
@property (copy, nonatomic) NSString *iconName;
//右边显示类型
@property (assign, nonatomic) meMessageCellType type;
  //右边显示内容
@property (copy, nonatomic) NSString *detail;
    //显示cell的子标题
@property (copy, nonatomic) NSString *subTitle;
//左边显示什么图片
@property (copy, nonatomic) NSString *pictureName;

    //监听cell点击事件
@property (copy, nonatomic) void(^action)();
    
    //快速建模对象
+ (instancetype)modelWithTitle:(NSString *)title pictureName:(NSString *)pictureName   type:(meMessageCellType)type;
@end

