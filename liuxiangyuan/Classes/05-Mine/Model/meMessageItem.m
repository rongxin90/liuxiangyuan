//
//  meMessageItem.m
//  liuxiangyuan
//
//  Created by 桂荣信 on 2018/11/5.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "meMessageItem.h"

@implementation meMessageItem
+ (instancetype)modelWithTitle:(NSString *)title type:(meMessageCellType)type{
    
    meMessageItem *model = [[self alloc] init];
    model.title = title;
    model.type = type;

    return model;
}

+ (instancetype)modelWithTitle:(NSString *)title pictureName:(NSString *)pictureName type:(meMessageCellType)type{
    
    meMessageItem *model = [[self alloc] init];
    model.title = title;
    model.type = type;
    model.pictureName = pictureName;
    return model;
}
    
@end
