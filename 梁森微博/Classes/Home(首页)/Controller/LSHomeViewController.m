//
//  LSHomeViewController.m
//  梁森微博
//
//  Created by pro on 16/4/8.
//  Copyright © 2016年 LS. All rights reserved.
//

#import "LSHomeViewController.h"

// 创建左右侧按钮的一个分类
#import "UIBarButtonItem+Item.h"
// 标题按钮
#import "LSTitleBtn.h"

// 蒙板
#import "LSCoverView.h"
// 弹出菜单
#import "LSPopMenu.h"

#import "LSMenuController.h"

// 跳转到的下一个视图控制器
#import "LSOneViewController.h"

#import "AFNetworking.h"
// 用于存储获取到的数据
#import "LSAccountTool.h"
// 获取数据的模型
#import "LSAccount.h"
// 获取当前登录用户及其所关注（授权）用户的最新微博  模型
#import "LSStatusesModel.h"

#import "UIImageView+WebCache.h"
// 网络请求工具类
#import "LSHttpTool.h"
// 刷新
#import "MJRefresh.h"
// 数据层
#import "LSStatusTool.h"
// 自定义单元格
#import "LSInfoCell.h"
// 请求数据时的参数模型
#import "LSStatusParam.h"
// VM模型
#import "LSStatusFrame.h"
//
#import "LSTabBar.h"
@interface LSHomeViewController ()<CoverViewClickDeleagate> // 遵守协议

@property (nonatomic, strong) UIButton * titleBtn;

@property (nonatomic, strong) LSMenuController * menuVC;
/**
 *  数据源:装的是LSStatusFrame模型
 */
@property (nonatomic, strong) NSMutableArray * statusFrames;

@end

@implementation LSHomeViewController

- (NSMutableArray *)statusFrames
{
    if (_statusFrames == nil) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (LSMenuController *)menuVC
{
    if (_menuVC == nil) {
        _menuVC = [[LSMenuController alloc] init];
    }
    return _menuVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    // 去除分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 设置导航条内容
    [self setUpNavgationBar];
    
    // 添加下拉刷新控件
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewData)];
    
    // 自动下拉刷新
    [self.tableView headerBeginRefreshing];
    
    // 添加上拉刷新控件
//    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStatus)];
    
    // 获取用户名
   
    
}
/**
 *  刷新最新微博数
 */
- (void)refresh
{
    [self.tableView headerBeginRefreshing];
}

- (void)loadNewData
{
  
    NSString *sinceId = nil;
    if (self.statusFrames.count) { // 有微博数据，才需要下拉刷新
        
        LSStatusFrame * model = self.statusFrames[0];
        LSStatusesModel * statusModel = model.status;
        sinceId = statusModel.idstr;
    }
    // 利用数据层获取数据
    [LSStatusTool newStatusWithSinceId:sinceId success:^(NSArray * array) {
        
        // 传递过来的是模型数组（模型是微博模型）
        [self.tableView headerEndRefreshing];
        // 用来装视图模型
        NSMutableArray * statusFrameArr = [NSMutableArray array];
        for (LSStatusesModel * statuesModel in array) {
            // 视图模型
            LSStatusFrame * statusFrame = [[LSStatusFrame alloc] init];
            // 将模型传递给视图模型
            statusFrame.status = statuesModel;
            [statusFrameArr addObject:statusFrame];
        }
        
        [self showNewDataWithCounts:array.count];
        
        NSIndexSet * indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, array.count)];
        [self.statusFrames insertObjects:statusFrameArr atIndexes:indexSet];
        NSLog(@"%@", self.statusFrames);
        
        [self.tableView reloadData];
    } failure:^(NSError * error) {
        
        NSLog(@"错误信息:%@", error);
        
    }];
    
}
// 显示新的微博数
- (void)showNewDataWithCounts:(NSUInteger)counts
{
    NSLog(@"最新微博数：%lu", counts);
    if (counts == 0) {
        // 如果没有最新的数据就不显示
        return;
    }
    CGFloat h = 35;
    CGFloat w = WIDTH;
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame) - h;
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, y, w, h)];
    label.text = [NSString stringWithFormat:@"假的最新微博数：%lu", counts];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];// [UIColor yellowColor];
    // 将label添加到navigationController的视图上
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    // 添加动画
    [UIView animateWithDuration:0.3 animations:^{
        
        label.transform = CGAffineTransformMakeTranslation(0, h);
        
    } completion:^(BOOL finished) {
        // 往上面平移
        [UIView animateWithDuration:0.25 delay:1.5 options:UIViewAnimationOptionCurveLinear animations:^{
            
            // 还原
            label.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}

- (void)loadMoreStatus
{
    // 创建一个参数字典
    LSStatusParam * param = [[LSStatusParam alloc] init];
    
    if (self.statusFrames.count) { // 有微博数据，才需要下拉刷新
        
        long long maxId = [[[self.statusFrames lastObject] idstr] longLongValue] - 1;
        param.max_id = [NSString stringWithFormat:@"%lld",maxId];
    }
    param.access_token = [LSAccountTool account].access_token;
    
    [LSStatusTool getMoreDataWithStr:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.keyValues success:^(id array) {
        // 结束上拉刷新
        [self.tableView footerEndRefreshing];
        [self.statusFrames addObjectsFromArray:array];
        // 刷新表格
        [self.tableView reloadData];
        
    } failure:^(NSError * error) {
        
    }];

}

// 设置导航条内容
- (void)setUpNavgationBar
{
    // 分类中的方法是一个类方法
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_friendsearch"] highImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] target:self action:@selector(friendsSearch) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_pop"] highImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] target:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    
    // 标题按钮
    LSTitleBtn * titleBtn = [LSTitleBtn buttonWithType:UIButtonTypeCustom];
    [titleBtn setTitle:@"首页" forState:UIControlStateNormal];
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateSelected];
//    titleBtn.backgroundColor = [UIColor redColor];
    [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    _titleBtn = titleBtn;
    self.navigationItem.titleView = titleBtn;
    
    
}
// 左右侧按钮的点击事件
- (void)friendsSearch
{
    
}
- (void)pop
{
    LSOneViewController * oneVC = [[LSOneViewController alloc] init];
    // 隐藏tabBar
    oneVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:oneVC animated:YES];
}

// 标题按钮的点击事件
- (void)titleClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    // 弹出蒙板
    LSCoverView * coverView = [LSCoverView show];
    coverView.delegate = self;
    
   
    CGFloat popW = 200;
    CGFloat popX = (self.view.width - 200) * 0.5;
    CGFloat popH = popW;
    CGFloat popY = 55;
     // 弹出菜单  此方法是有返回值的
    LSPopMenu * menu = [LSPopMenu showWithRect:CGRectMake(popX, popY, popW, popH)];
    // 设置菜单的内容视图
    menu.contenView = self.menuVC.view;
//    [menu setContenView:self.menuVC.view];
}
// 实现协议中的方法
- (void)didClickCoverView
{
    // 控制title按钮的图片
    _titleBtn.selected = !_titleBtn.selected;
    // 隐藏菜单
    [LSPopMenu hide];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSLog(@"---数组个数---%lu", _statusFrames.count);
    return _statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s", __func__);
    LSInfoCell * cell = [LSInfoCell cellWithTableView:tableView];
    // 数组中装的是视图模型
    LSStatusFrame * statusFrameModel = self.statusFrames[indexPath.row];
//    cell.textLabel.text = statusFrameModel.status.text;
    cell.status = statusFrameModel;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSStatusFrame * statusFrameModel = self.statusFrames[indexPath.row];
    // statusFrame.status = statuesModel;的时候已经将模型传递了过去
//    NSLog(@"---单元格高度－－－%f", statusFrameModel.cellHeight);
    return statusFrameModel.cellHeight;
}

@end
