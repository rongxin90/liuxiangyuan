//
//  HtmlModel.h
//  liuxiangyuan
//
//  Created by 桂荣信 on 2017/3/22.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HtmlModel : NSObject

//js格式内容
@property (strong, nonatomic) NSString *content;

//标题
@property (strong, nonatomic) NSString *title;


@property (strong, nonatomic) NSString *intime;
@end
