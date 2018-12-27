//
//  clientController.m
//  socket
//
//  Created by 桂荣信 on 2018/12/26.
//  Copyright © 2018年 guirongxin. All rights reserved.
//

#import "clientController.h"
#import "GCDAsyncSocket.h"

@interface clientController ()<GCDAsyncSocketDelegate>
@property (weak, nonatomic) IBOutlet UITextField *fasongxinxi;
@property (weak, nonatomic) IBOutlet UITextField *ipdizhi;
@property (weak, nonatomic) IBOutlet UITextField *duankouhao;
// 客户端socket
@property (strong, nonatomic) GCDAsyncSocket *clientSocket;
@property (weak, nonatomic) IBOutlet UITextView *zhanshi;

@end

@implementation clientController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 1.初始化
    self.clientSocket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
}
- (IBAction)lianjie:(id)sender {
    [self.clientSocket connectToHost:self.ipdizhi.text onPort:self.duankouhao.text.integerValue viaInterface:nil withTimeout:-1 error:nil];
}
- (IBAction)fasong:(id)sender {
    NSData *data = [self.fasongxinxi.text dataUsingEncoding:NSUTF8StringEncoding];
//    NSString *str = self.fasongxinxi.text;
//    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    // withTimeout -1 : 无穷大,一直等
    // tag : 消息标记
    [self.clientSocket writeData:data withTimeout:- 1 tag:0];
}
- (IBAction)jieshou:(id)sender {
    
    [self.clientSocket readDataWithTimeout:11 tag:0];
}

#pragma mark - GCDAsyncSocketDelegate

//连接成功会调用的方法
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    [self showMessageWithStr:@"链接成功"];
    NSLog(@"链接成功");
    
    [self showMessageWithStr:[NSString stringWithFormat:@"服务器IP: %@", host]];
    //    NSLog(@"%@",_clientSocket);
    [self.clientSocket readDataWithTimeout:- 1 tag:0];
}

// 收到消息
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    NSString *text = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    [self showMessageWithStr:text];
    
//    NSLog(@"%@",text);
    
    [sock readDataWithTimeout:- 1 tag:0];
}


//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.view endEditing:YES];
//
//}

// 信息展示
- (void)showMessageWithStr:(NSString *)str {
    self.zhanshi.text = [self.zhanshi.text stringByAppendingFormat:@"%@\n", str];
}



// 链接失败
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    
    [self showMessageWithStr:@"链接失败"];
    [self.clientSocket connectToHost:self.ipdizhi.text onPort:self.duankouhao.text.integerValue viaInterface:nil withTimeout:-1 error:nil];
}


@end
