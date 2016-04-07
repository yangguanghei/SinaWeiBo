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

+ (void)initialize
{
    // appearanceWhenContainedIn：获取当前类下的所有外观
    UITabBarItem * item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
//    [dic setObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
    dic[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:dic forState:UIControlStateSelected];
}

#pragma mark -------管理子控制器
- (void)setUpChildVC
{
    // 首页
    UIViewController *home = [[UIViewController alloc] init];
    [self setUPchildVC:home withImage:[UIImage imageNamed:@"tabbar_home"] withSelectedImage: [UIImage imageWithOriginalName:@"tabbar_home_selected"]withTitle:@"首页"];
    home.view.backgroundColor = [UIColor greenColor];
    [self addChildViewController:home];
    
    // 消息
    UIViewController *message = [[UIViewController alloc] init];
    [self setUPchildVC:message withImage:[UIImage imageNamed:@"tabbar_message_center"] withSelectedImage:[UIImage imageWithOriginalName:@"tabbar_message_center_selected"] withTitle:@"消息"];
    message.view.backgroundColor = [UIColor blueColor];
    
    [self addChildViewController:message];
    
    // 发现
    UIViewController *discover = [[UIViewController alloc] init];
    [self setUPchildVC:discover withImage:[UIImage imageNamed:@"tabbar_discover"] withSelectedImage:[UIImage imageWithOriginalName:@"tabbar_discover_selected"] withTitle:@"发现"];
    discover.view.backgroundColor = [UIColor purpleColor];
    
    [self addChildViewController:discover];
    
    // 我
    UIViewController *profile = [[UIViewController alloc] init];
    [self setUPchildVC:profile withImage:[UIImage imageNamed:@"tabbar_profile"] withSelectedImage:[UIImage imageWithOriginalName:@"tabbar_profile_selected"] withTitle:@"我"];
    profile.view.backgroundColor = [UIColor lightGrayColor];
    
    [self addChildViewController:profile];
}

#pragma mark --------抽取代码，添加子控制器
- (void)setUPchildVC:(UIViewController *)VC withImage:(UIImage *)image withSelectedImage:(UIImage *)selectedImage withTitle:(NSString *)title
{
    VC.tabBarItem.image = image;
    VC.tabBarItem.selectedImage = selectedImage;
    VC.tabBarItem.title = title;
    
    [self addChildViewController:VC];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
