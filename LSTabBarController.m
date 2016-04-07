//
//  LSTabBarController.m
//  梁森微博
//
//  Created by pro on 16/4/7.
//  Copyright © 2016年 LS. All rights reserved.
//

#import "LSTabBarController.h"
#import "UIImage+LSImage.h"
@interface LSTabBarController ()

@end

@implementation LSTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 管理子控制器
    [self setUpChildVC];
    
}
#pragma mark -------管理子控制器
- (void)setUpChildVC
{
    // 首页
    UIViewController *home = [[UIViewController alloc] init];
    home.tabBarItem.title = @"首页";
    // 图片提示的插件
    home.tabBarItem.image = [UIImage imageNamed:@"tabbar_home"];
//    UIImage * selectedImage = [UIImage imageNamed:@"tabbar_home_selected"];
    // 让图片显示原来的样式
//    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 使用分类
    home.tabBarItem.selectedImage = [UIImage imageWithOriginalName:@"tabbar_home_selected"];
    home.view.backgroundColor = [UIColor greenColor];
    
    [self addChildViewController:home];
    
    // 消息
    UIViewController *message = [[UIViewController alloc] init];
    message.tabBarItem.title = @"消息";
    message.tabBarItem.image = [UIImage imageNamed:@"tabbar_message_center"];
    message.tabBarItem.selectedImage = [UIImage imageWithOriginalName:@"tabbar_message_center_selected"];
    message.view.backgroundColor = [UIColor blueColor];
    
    [self addChildViewController:message];
    
    // 发现
    UIViewController *discover = [[UIViewController alloc] init];
    discover.tabBarItem.title = @"发现";
    discover.tabBarItem.image = [UIImage imageNamed:@"tabbar_discover"];
    discover.tabBarItem.selectedImage = [UIImage imageWithOriginalName:@"tabbar_discover_selected"];
    discover.view.backgroundColor = [UIColor purpleColor];
    
    [self addChildViewController:discover];
    
    // 我
    UIViewController *profile = [[UIViewController alloc] init];
    profile.tabBarItem.title = @"我";
    profile.tabBarItem.image = [UIImage imageNamed:@"tabbar_profile"];
    profile.tabBarItem.selectedImage = [UIImage imageWithOriginalName:@"tabbar_profile_selected"];
    profile.view.backgroundColor = [UIColor lightGrayColor];
    
    [self addChildViewController:profile];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
