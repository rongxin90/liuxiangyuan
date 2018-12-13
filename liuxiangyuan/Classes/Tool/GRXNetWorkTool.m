//
//  GRXNetWorkTool.m
//  liuxiangyuan
//
//  Created by 桂荣信 on 2017/3/17.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "GRXNetWorkTool.h"
#import <AFNetworking/AFNetworking.h>
@interface GRXNetWorkTool()

@end
@implementation GRXNetWorkTool

+ (void)grx_loadDataWithUrlString:(NSString *)urlString andParameter:(id)parameter  reloadData:(void(^)(NSDictionary *reloadData))reloadData{
    
    
    //    NSString *urlString = @"http://zmapi.4001113900.com:8088/lxyUserLoginAction!login.action";
    //    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    //    [dict setObject:@"15267120629" forKey:@"loginName"];
    //    [dict setObject:@"5578777132" forKey:@"loginPwd"];
    //    NSDictionary *pagram = @{@"loginName":@"15267120629",
    //                             @"loginPwd":@"f86dead02f941838078807913f3665c0"
    //                             };
    AFHTTPSessionManager *mag = [AFHTTPSessionManager manager];
    [mag GET:urlString parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"++%@--",[NSThread currentThread]);
        reloadData(responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"数据请求失败");
    }];
}

@end
