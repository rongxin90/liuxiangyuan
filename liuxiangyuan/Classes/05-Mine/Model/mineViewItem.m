//
//  mineViewItem.m
//  liuxiangyuan
//
//  Created by 桂荣信 on 2018/11/9.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "mineViewItem.h"

@implementation mineViewItem

+(instancetype)modelWithTitle:(NSString *)title andPictureName:(NSString *)pictureName subTitle:(NSString *)subTitle withType:(mineViewCellType)type{
    
    mineViewItem *item = [[self alloc] init];
    item.title = title;
        item.pictureName = pictureName;


    item.pictureName = pictureName;
    if (subTitle) {
        item.subTitle =subTitle;
    }else{
        item.subTitle = nil;
    }
    item.type = type;
    return item;
    
}
@end
