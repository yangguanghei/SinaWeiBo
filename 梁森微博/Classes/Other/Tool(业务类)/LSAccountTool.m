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

@end
