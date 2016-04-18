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

#define Client_id @"3460952036"
#define Redirect_uri @"http://www.baidu.com"
#define Client_secret @"fa2fa5bae5e91b4c6b938b2aea431eb2"


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
    /*
     client_id	true	string	申请应用时分配的AppKey。
     client_secret	true	string	申请应用时分配的AppSecret。
     grant_type	true	string	请求的类型，填写authorization_code
     
     grant_type为authorization_code时
     必选	类型及范围	说明
     code	true	string	调用authorize获得的code值。
     redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。

     */
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    NSString * baseURLStr = @"https://api.weibo.com/oauth2/access_token";
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    parameters [@"client_id"] = Client_id;
    parameters [@"client_secret"] = Client_secret;
    parameters [@"grant_type"] = @"authorization_code";
    parameters [@"code"] = code;
    parameters [@"redirect_uri"] = Redirect_uri;
    [manager POST:baseURLStr parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        
//        NSLog(@"成功：%@", responseObject);
        // 保存获取到的AccessToken
        LSAccount * account = [LSAccount applicationWithDic:responseObject];
        // 归档必须遵循NSCoding协议
        [LSAccountTool saveAccount:account];
        
        // 将accessToken保存之后选取根视图控制器
        [LSRootTool chooseRootViewController:LSKeyWindow];
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        NSLog(@"失败：%@", error);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
