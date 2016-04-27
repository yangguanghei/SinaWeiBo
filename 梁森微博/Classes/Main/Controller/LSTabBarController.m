//
//  LSTabBarController.m
//  梁森微博
//
//  Created by pro on 16/4/7.
//  Copyright © 2016年 LS. All rights reserved.
//

#import "LSTabBarController.h"
#import "UIImage+LSImage.h"
// 自定义tabBar
#import "LSTabBar.h"

#import "LSHomeViewController.h"
#import "LSMessageViewController.h"
#import "LSDiscoverViewController.h"
#import "LSProfileViewController.h"

#import "LSNavigationController.h"
@interface LSTabBarController ()<UITabBarDelegate>

@property (nonatomic, strong)LSHomeViewController * homeVC;
@property (nonatomic, strong) LSMessageViewController * messageVC;
@property (nonatomic, strong) LSDiscoverViewController * discoverVC;
@property (nonatomic, strong) LSProfileViewController * profileVC;
/**
 *  记录上一次点击的tabBar下标
 */
@property(readonly, nonatomic) NSUInteger lastSelectedIndex;

@end

@implementation LSTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 管理子控制器
    [self setUpChildVC];
    
    LSTabBar * lsTabBar = [[LSTabBar alloc] initWithFrame:self.tabBar.frame];
    lsTabBar.delegate = self;
    
    //    self.tabBar = lsTabBar;
    // 利用KVC对进行赋值，改变只读属性
    // 现在的self.tabBar就成了我们自己定义的lsTabBar
    
    // 这块代码怎么变了？？／
    // 先按这种方式来
    [self setValue:lsTabBar forKey:@"tabBar"];

    
    // 此时还没有子视图控制器
    NSLog(@"viewDidLod:---%@", self.tabBar.subviews);
    NSLog(@"---%@", self.childViewControllers);
    
    // 要每隔一段时间请求一次  刷新未读数
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(requestUnread) userInfo:nil repeats:YES];
    
}
// 每隔三秒就刷新一次，刷新tabBar上的未读数
- (void)requestUnread
{
    NSLog(@"定时刷新。。。");
    _homeVC.tabBarItem.badgeValue = @"1";
    // 未读数显示在应用图标上,前提：注册通知
    [UIApplication sharedApplication].applicationIconBadgeNumber = 3;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    
    NSLog(@"viewDidAppear:---%@", self.tabBar.subviews);
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
    LSHomeViewController *home = [[LSHomeViewController alloc] init];
    [self setUPchildVC:home withImage:[UIImage imageNamed:@"tabbar_home"] withSelectedImage: [UIImage imageWithOriginalName:@"tabbar_home_selected"]withTitle:@"首页"];
//    [self setUPchildVC:home withImage:[UIImage imageNamed:@""] withSelectedImage: [UIImage imageWithOriginalName:@""]withTitle:@"首页"];
    home.view.backgroundColor = [UIColor greenColor];
    _homeVC = home;
    
    // 消息
    LSMessageViewController *message = [[LSMessageViewController alloc] init];
    [self setUPchildVC:message withImage:[UIImage imageNamed:@"tabbar_message_center"] withSelectedImage:[UIImage imageWithOriginalName:@"tabbar_message_center_selected"] withTitle:@"消息"];
    message.view.backgroundColor = [UIColor blueColor];
    _messageVC = message;
    
    // 发现
    LSDiscoverViewController *discover = [[LSDiscoverViewController alloc] init];
    [self setUPchildVC:discover withImage:[UIImage imageNamed:@"tabbar_discover"] withSelectedImage:[UIImage imageWithOriginalName:@"tabbar_discover_selected"] withTitle:@"发现"];
    discover.view.backgroundColor = [UIColor purpleColor];
    _discoverVC = discover;
    
    
    // 我
    LSProfileViewController *profile = [[LSProfileViewController alloc] init];
    [self setUPchildVC:profile withImage:[UIImage imageNamed:@"tabbar_profile"] withSelectedImage:[UIImage imageWithOriginalName:@"tabbar_profile_selected"] withTitle:@"我"];
    profile.view.backgroundColor = [UIColor lightGrayColor];
    _profileVC = profile;
    
}

#pragma mark --------抽取代码，添加子控制器
- (void)setUPchildVC:(UIViewController *)VC withImage:(UIImage *)image withSelectedImage:(UIImage *)selectedImage withTitle:(NSString *)title
{
    VC.tabBarItem.image = image;
    VC.tabBarItem.selectedImage = selectedImage;
    VC.tabBarItem.title = title;
    VC.tabBarItem.badgeValue = @"";
    
    LSNavigationController * nav = [[LSNavigationController alloc] initWithRootViewController:VC];
    
    [self addChildViewController:nav];
    
}
#pragma mark -------- UITabBarDelegate

// 点击以后再次点击不再响应
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    
    //    NSLog(@"%lu", self.selectedIndex);
    //获得选中的item
    NSUInteger tabIndex = [tabBar.items indexOfObject:item];
    
//    NSLog(@"当前tabBar的下标%lu  上一次被选中的下标%lu", tabIndex, self.selectedIndex);
    
    if (tabIndex != self.selectedIndex) {   // 如果点击的tabBar和被选中的tabBar不相同
        //设置最近一次变更
//        _lastSelectedIndex = self.selectedIndex;    // 把被选中的下标赋值给上一次被选中的下标
//        NSLog(@"2 OLD:%lu , NEW:%lu",self.lastSelectedIndex,tabIndex);
        NSLog(@"当前下标和上一次被选中的下标不相同");
    } else
    {
        NSLog(@"当前下标和上一次被选中的下标相同");
        if (tabIndex == 0) {
            [_homeVC refresh];
        }
//        NSLog(@"---%lu", self.selectedIndex);
//        NSLog(@"可以进行刷新操作。。。");
    }
}
- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    NSLog(@"%s", __func__);
    //判断是否相等,不同才设置
    if (self.selectedIndex != selectedIndex) {
        //设置最近一次
        _lastSelectedIndex = self.selectedIndex;
        NSLog(@"1 OLD:%lu , NEW:%lu",self.lastSelectedIndex,selectedIndex);
    }
    
    //调用父类的setSelectedIndex
    [super setSelectedIndex:selectedIndex];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
