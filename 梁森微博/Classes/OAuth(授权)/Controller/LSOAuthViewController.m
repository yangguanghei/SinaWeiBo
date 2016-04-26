//
//  LSOAuthViewController.m
//  梁森微博
//
//  Created by pro on 16/4/18.
//  Copyright © 2016年 LS. All rights reserved.
//

#import "LSOAuthViewController.h"

#import "MBProgressHUD.h"

#import "SVProgressHUD.h"

#import "AFHTTPRequestOperationManager.h"
// 业务类
#import "LSAccount.h"
// 工具类
#import "LSAccountTool.h"

#import "LSRootTool.h"

// 网络请求工具类
#import "LSHttpTool.h"
@interface LSOAuthViewController ()<UIWebViewDelegate>

@end

@implementation LSOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIWebView * webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.delegate = self;
    [self.view addSubview:webView];
    
    // 基本URL：https://api.weibo.com/oauth2/authorize
    NSString * baseURL = @"https://api.weibo.com/oauth2/authorize";
    /*
     client_id	true	string	申请应用时分配的AppKey。
     redirect_uri	true	string
     */
    NSString * client_id = @"3460952036";
    NSString * redirect_uri = @"http://www.baidu.com";
    
    NSString * urlStr = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@", baseURL, client_id, redirect_uri];
    NSURL * url = [NSURL URLWithString:urlStr];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [SVProgressHUD showWithStatus:@"加载中。。。"];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD showSuccessWithStatus:@"加载完成"];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
//    [SVProgressHUD showErrorWithStatus:@""];
    // 隐藏
    [SVProgressHUD dismiss];
}
// 拦截web View请求
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString * requestURLStr = request.URL.absoluteString;
    NSRange range = [requestURLStr rangeOfString:@"code="];
    if (range.length) {
        NSString * code = [requestURLStr substringFromIndex:range.location + range.length];
        NSLog(@"code:%@", code);
        
        // 获取Access Token
        [self getAccessTokenWithCode:code];
        // 不加载回调页面
        return NO;
    }
    return YES;
}

- (void)getAccessTokenWithCode:(NSString *)code
{
      
    [LSAccountTool accountWithCode:code success:^{
        [LSRootTool chooseRootViewController:LSKeyWindow];
    } failure:^(NSError *error) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
