//
//  LSSendViewController.m
//  梁森微博
//
//  Created by 梁森 on 16/5/9.
//  Copyright © 2016年 LS. All rights reserved.
//

#import "LSSendViewController.h"
//#import "UIBarButtonItem+Item.h"
@interface LSSendViewController ()

@end

@implementation LSSendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"发送微博";
    
    [self setUpLeftAndRightItem];
}

- (void)setUpLeftAndRightItem
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    
    UIButton * rightItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightItem setTitle:@"发送" forState:UIControlStateNormal];
    [rightItem setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [rightItem setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [rightItem sizeToFit];
    [rightItem addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightItem];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)cancel
{
//    NSLog(@"%s", __func__);
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)send
{
//    NSLog(@"%s", __func__);
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
