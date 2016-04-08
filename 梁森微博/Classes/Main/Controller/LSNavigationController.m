//
//  LSNavigationController.m
//  梁森微博
//
//  Created by pro on 16/4/8.
//  Copyright © 2016年 LS. All rights reserved.
//

#import "LSNavigationController.h"

@interface LSNavigationController ()

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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:YES];
    // 可以让所有导航控制器上的某些东西变的一样
//    viewController.navigationItem.leftBarButtonItem
    NSLog(@"重写的push方法。。。");
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
