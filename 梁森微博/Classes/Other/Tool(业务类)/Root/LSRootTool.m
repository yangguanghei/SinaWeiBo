//
//  LSRootTool.m
//  梁森微博
//
//  Created by pro on 16/4/18.
//  Copyright © 2016年 LS. All rights reserved.
//

#import "LSRootTool.h"

#import "LSRootCollectionViewController.h"
#import "LSTabBarController.h"

#define LastVersion @"lastVersion"
@implementation LSRootTool
+ (void)chooseRootViewController:(UIWindow *)window
{
    // 判断当前的版本号
    NSString * currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    // 上一次版本号
    NSString * lastVersionStr = [[NSUserDefaults standardUserDefaults] objectForKey:LastVersion];
    if (![currentVersion isEqualToString:lastVersionStr]) {
        LSRootCollectionViewController * rootCVC = [[LSRootCollectionViewController alloc] init];
        window.rootViewController = rootCVC;
    } else
    {
        LSTabBarController * tabBarVc = [[LSTabBarController alloc] init];
        
        
        
        window.rootViewController = tabBarVc;
    }
    // 将当前版本号存储起来
    [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:LastVersion];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
