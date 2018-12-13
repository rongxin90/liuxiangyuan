//
//  GRXHTMLController.m
//  liuxiangyuan
//
//  Created by 桂荣信 on 2017/3/22.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "GRXHTMLController.h"
#import "UIView+Frame.h"
#import "GRXNetWorkTool.h"
#import <MJExtension/MJExtension.h>
#import "HtmlModel.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
@interface GRXHTMLController ()<WKScriptMessageHandler,WKNavigationDelegate,WKUIDelegate>
{
    NSMutableArray *_dataArray;
    WKWebView *_webView;
    NSString *_title;
    NSString *_time;
    NSString *_content;
    
}

@property (strong, nonatomic) NSString *url;
@end

@implementation GRXHTMLController


-(void)viewDidLoad{
    
    [super viewDidLoad];
    
//    NSLog(@"viewDidLoad=---%@",self.url);
//    _title = [NSString string];
//    _dataArray = [NSMutableArray array];
    [self addSubviewsWithUrl:self.url];
    [self loadDataWithUrl:self.url];
}

- (instancetype)initWithUrl:(NSString *)urlString
{
    self = [super init];
    if (self) {
        self.url = urlString;
//        NSLog(@"%@initWithUrl",urlString);

        
    }
    return self;
}

- (void)addSubviewsWithUrl:(NSString *)urlString{
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
//    config.userContentController = [[WKUserContentController alloc] init];
    config.selectionGranularity =WKSelectionGranularityDynamic;
    config.allowsInlineMediaPlayback = YES;
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptEnabled = YES;
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    config.preferences = preferences;
    //注册js方法
//    [config.userContentController addScriptMessageHandler:self name:@"loading"];
    
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) configuration:config];
 
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.navigationDelegate = self;
    
   
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"title_time_body_template" withExtension:@"html"];;
//    [_webView loadHTMLString:str baseURL:url];
//    NSString *str  = @"https://www.baidu.com/";
//    NSURL *urlStr = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [_webView loadFileURL:url allowingReadAccessToURL:url];
    [_webView loadRequest:request];
    _webView.UIDelegate = self;
     [self.view addSubview:_webView];
    
}


/**
 *  web界面中有弹出警告框时调用
 *
 *  @param webView           实现该代理的webview
 *  @param message           警告框中的内容
 *  @param frame             主窗口
 *  @param completionHandler 警告框消失调用
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
}



- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
//    NSLog(@"%@",message);
}



-(void)loadDataWithUrl:(NSString *)urlString{
//    NSLog(@"%@",urlString);
    
    __weak typeof(self) weakSelf = self;
//    if (_model == nil) {
        [GRXNetWorkTool grx_loadDataWithUrlString:urlString andParameter:nil reloadData:^(NSDictionary *reloadData) {
            NSLog(@"%@",reloadData);
            NSDictionary *dict = reloadData[@"data"];
            HtmlModel *model = [HtmlModel mj_objectWithKeyValues:dict];
            weakSelf.model = model;
  
        }];
//    }
 
    

}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"loading"]) {
        NSLog(@"loading");
    }else if ([keyPath isEqualToString:@"title"])
    {
        NSLog(@"title-----%@",_webView.title);
    }else if([keyPath isEqualToString:@"estimatedProgress"]){
        NSLog(@"estimatedProgress-----%f",_webView.estimatedProgress);
    }
    
   
}

#pragma mark---WKNavigationDelegate
//页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
//    NSLog(@"页面开始加载时调用");
}

//当页面返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
//    NSLog(@"当页面返回时调用");
}

//页面加载完成之后调用
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    
    //修改标题
    
    

    NSString *str = [NSString stringWithFormat:@"$('h1')[0].innerText = '%@';$('.subtitle')[0].innerText = '%@';",self.model.title,self.model.intime];
//    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    

        [_webView evaluateJavaScript:str completionHandler:^(id _Nullable response, NSError * _Nullable error) {
            NSLog(@"%@-----%@",response,error);
        }];

    
    

    NSString *htmlInsert = [NSString stringWithFormat:@"$('.body_content').html('%@')",self.model.content];
//    htmlInsert = [htmlInsert stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [_webView evaluateJavaScript:htmlInsert completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        NSLog(@"response=%@-----error=%@",response,error);
    }];

    
}

//页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
//    NSLog(@"页面加载失败时调用");
}

@end
