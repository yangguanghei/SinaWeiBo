//
//  LSNavigationController.m
//  梁森微博
//
//  Created by pro on 16/4/8.
//  Copyright © 2016年 LS. All rights reserved.
//

#import "LSNavigationController.h"

// 创建左右侧按钮的一个分类
#import "UIBarButtonItem+Item.h"
@interface LSNavigationController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) id popDelegate;

@end

@implementation LSNavigationController

+ (void)initialize
{
    // 统一导航条上内容的形式
    UIBarButtonItem * item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    // 设置左右侧按钮上的字体颜色为orange
    dic[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:dic forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 返回按钮即使是自定义的也可以有“滑动返回功能”
    _popDelegate = self.interactivePopGestureRecognizer.delegate;
    
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 导航控制器跳转完成时调用

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
//    NSLog(@"%s", __func__);
//    NSLog(@"======0========%@", self.viewControllers[0]);
    if (viewController == self.viewControllers[0] ) {   // 如果显示的是根视图控制器
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
    } else
    {
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    
    // 设置的控制器是非根视图控制器
    // 让跳转的所有视图控制器的导航条格式一样
    if (self.viewControllers.count != 0) {
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] target:self action:@selector(returnBack) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_more"] highImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] target:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    [super pushViewController:viewController animated:YES];
    // 可以让所有导航控制器上的某些东西变的一样
//    viewController.navigationItem.leftBarButtonItem
    NSLog(@"重写的push方法。。。");
}

- (void)returnBack
{
    NSLog(@"返回。。。");
    [self popViewControllerAnimated:YES];
}
- (void)moreBtnClick
{
    [self popToRootViewControllerAnimated:YES];
}

@end
