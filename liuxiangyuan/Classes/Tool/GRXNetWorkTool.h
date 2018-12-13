//
//  GRXNetWorkTool.h
//  liuxiangyuan
//
//  Created by 桂荣信 on 2017/3/17.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRXNetWorkTool : NSObject
+ (void)grx_loadDataWithUrlString:(NSString *)urlString andParameter:(id)parameter  reloadData:(void(^)(NSDictionary *reloadData))reloadData;
@end
