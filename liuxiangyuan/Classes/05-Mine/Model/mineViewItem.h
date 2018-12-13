//
//  mineViewItem.h
//  liuxiangyuan
//
//  Created by 桂荣信 on 2018/11/9.
//  Copyright © 2018年 grx. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    mineViewCellTypeDefault,
    mineViewCellTypeArrow,
    mineViewCellTypeSubtitle,
    mineViewItemTypeIcon
    
}mineViewCellType;


@interface mineViewItem : NSObject

//左边显示图片的名称
@property (copy, nonatomic) NSString *pictureName;

//左边自定义显示图片名称
@property (copy, nonatomic) NSString *iconName;

//左边显示什么主题
@property (copy, nonatomic) NSString *title;

//左边显示什么子标题
@property (copy, nonatomic) NSString *subTitle;

//右边显示的图片名称
@property (copy, nonatomic) NSString *arrowName;

//显示什么类型的cell
@property (assign, nonatomic) mineViewCellType type;

//选中需要执行的操作
@property (copy, nonatomic)void(^action)();

+(instancetype)modelWithTitle:(NSString *)title andPictureName:(NSString *)pictureName subTitle:(NSString *)subTitle withType:(mineViewCellType)type;

@end


