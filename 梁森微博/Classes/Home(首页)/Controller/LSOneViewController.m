//
//  LSOneViewController.m
//  梁森微博
//
//  Created by pro on 16/4/15.
//  Copyright © 2016年 LS. All rights reserved.
//

#import "LSOneViewController.h"
// 跳转到的下一个视图控制器
#import "LSTwoViewController.h"
@interface LSOneViewController ()

@end

@implementation LSOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    LSTwoViewController * twoVC = [[LSTwoViewController alloc] init];
    
    [self.navigationController pushViewController:twoVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
