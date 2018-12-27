//
//  severController.m
//  socket
//
//  Created by 桂荣信 on 2018/12/26.
//  Copyright © 2018年 guirongxin. All rights reserved.
//

#import "severController.h"
#import "GCDAsyncSocket.h"
@interface severController ()<GCDAsyncSocketDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textFieldKou;//端口
@property (weak, nonatomic) IBOutlet UITextField *xinxi;//信息
@property (weak, nonatomic) IBOutlet UITextView *jieshou;//接受
// 服务器socket(开放端口,监听客户端socket的链接)
@property (strong, nonatomic) GCDAsyncSocket *serverSocket;
// 保存客户端socket
@property (strong, nonatomic) GCDAsyncSocket *clientSocket;
@end

@implementation severController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.初始化服务器socket, 在主线程里回调
    self.serverSocket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
}
- (IBAction)jinating:(id)sender {
    // 2.开放哪一个端口
    NSError *error = nil;
    BOOL result = [self.serverSocket acceptOnPort:self.textFieldKou.text.integerValue error:&error];
    if (result && error == nil) {
        // 开放成功
        [self showMessageWithStr:@"开放成功"];
    }
}

// 信息展示
- (void)showMessageWithStr:(NSString *)str {
    self.jieshou.text = [self.jieshou.text stringByAppendingFormat:@"%@\n", str];
}

// 发送消息
// socket是保存的客户端scket, 表示给这个socket客户端发送消息
- (IBAction)fasong:(id)sender {
    NSData *data = [self.xinxi.text dataUsingEncoding:NSUTF8StringEncoding];
    // withTimeout -1 : 无穷大,一直等
    
    if (self.clientSocket == nil) {
         [self showMessageWithStr:@"无客户端链接"];
    }
    // tag : 消息标记
    [self.clientSocket writeData:data withTimeout:-1 tag:0];
}


- (IBAction)jieshou:(id)sender {
    [self.clientSocket readDataWithTimeout:11 tag:0];
}

#pragma mark - 服务器socketDelegate
-(void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket{
    self.clientSocket = newSocket;
    [self showMessageWithStr:@"链接成功"];
    [self showMessageWithStr:[NSString stringWithFormat:@"服务器地址: %@  端口: %d", newSocket.connectedHost, newSocket.connectedPort]];
    [self.clientSocket readDataWithTimeout:- 1 tag:0];
}

// 收到消息
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    NSString *text = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    [self showMessageWithStr:text];
//    NSLog(@"%@",text);
    [self.clientSocket readDataWithTimeout:- 1 tag:0];
    
    if ([text rangeOfString:@"http://"].location == NSNotFound) {
        NSData *data1 = [@"请求格式错误" dataUsingEncoding:NSUTF8StringEncoding];
        //    // tag : 消息标记
        [self.clientSocket writeData:data1 withTimeout:-1 tag:0];
    } else {
        NSData *data1 = [@"返回json数据" dataUsingEncoding:NSUTF8StringEncoding];
        //    // tag : 消息标记
        [self.clientSocket writeData:data1 withTimeout:-1 tag:0];
    }

   
}

// 链接成功
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    
    NSLog(@"链接成功");
}

// 链接失败
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    
    [self showMessageWithStr:@"链接失败"];
}
@end
