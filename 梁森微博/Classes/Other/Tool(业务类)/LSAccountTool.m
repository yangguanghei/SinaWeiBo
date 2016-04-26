//
//  LSAccountTool.m
//  梁森微博
//
//  Created by pro on 16/4/18.
//  Copyright © 2016年 LS. All rights reserved.
//

#import "LSAccountTool.h"
#import "LSAccount.h"
static LSAccount * _account;

#import "LSAccount.h"
// 参数模型
#import "LSParamers.h"
// 网络层
#import "LSHttpTool.h"
// 李明杰第三方库
#import "MJExtension.h"

#define Client_id @"3460952036"
#define Redirect_uri @"http://www.baidu.com"
#define Client_secret @"fa2fa5bae5e91b4c6b938b2aea431eb2"

#define LSFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"] // 存储模型的文件路径
@implementation LSAccountTool

+ (void)saveAccount:(LSAccount *)account
{
    // 归档
    [NSKeyedArchiver archiveRootObject:account toFile:LSFilePath];
}

+ (LSAccount *)account
{
    // 解档
    if (_account == nil) {
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:LSFilePath];
        
        // 判断当前时间是否过期
        if ([[NSDate date] compare:_account.expiresDate] != NSOrderedAscending) { // 过期
            return nil;
        }
    }
    return _account;

}

+ (void)accountWithCode:(NSString *)code success:(void (^)())success failure:(void (^)(NSError *))failure
{
    
    // 创建参数模型
    LSParamers *param = [[LSParamers alloc] init];
    param.client_id = Client_id;
    param.client_secret = Client_secret;
    param.grant_type = @"authorization_code";
    param.code = code;
    param.redirect_uri = Redirect_uri;
    
    // 模型转字典
    [LSHttpTool Post:@"https://api.weibo.com/oauth2/access_token" parameters:param.keyValues success:^(id responseObject) {
        
        LSAccount * account = [LSAccount applicationWithDic:responseObject];
        [LSAccountTool saveAccount:account];
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
   
}

@end
