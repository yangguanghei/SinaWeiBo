//
//  LSInfoCell.m
//  梁森微博
//
//  Created by 梁森 on 16/4/27.
//  Copyright © 2016年 LS. All rights reserved.
//

#import "LSInfoCell.h"
// 三个子控件
#import "LSOriginalView.h"
#import "LSRetransmissionView.h"
#import "LSTollView.h"
// 视图模型
#import "LSStatusFrame.h"
@interface LSInfoCell()

@property (nonatomic, strong) LSOriginalView * origainal;
@property (nonatomic, strong) LSRetransmissionView * retransmission;
@property (nonatomic, strong) LSTollView * toll;

@end

@implementation LSInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 添加子控件
        [self setUpChildView];
        // 清空单元格的背景色
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)setUpChildView
{
    LSOriginalView * origainal = [[LSOriginalView alloc] init];
    [self addSubview:origainal];
    _origainal = origainal;
    
    LSRetransmissionView * retransmission = [[LSRetransmissionView alloc] init];
    [self addSubview:retransmission];
    _retransmission = retransmission;
    
    LSTollView * tool = [[LSTollView alloc] init];
    [self addSubview:tool];
    _toll = tool;
}
// 设置单元格的内容
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString * cellID = @"cellID";
    id cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    return cell;
}
/*
 问题：1.cell的高度应该提前计算出来
 2.cell的高度必须要先计算出每个子控件的frame，才能确定
 3.如果在cell的setStatus方法计算子控件的位置，会比较耗性能
 
 解决:MVVM思想
 
 */
// 在视图控制中将视图模型传递过来

- (void)setStatus:(LSStatusFrame *)status   // 该方法会每次都被调用
{
    _status = status;
    // 设置原创微博frame
    _origainal.frame = status.originalViewFrame;
    // 将视图模型再传递给单元格的各个子视图
    _origainal.status = status;
    
    // 设置原创微博frame
    _retransmission.frame = status.retweetViewFrame;
    _retransmission.statusF = status;
    
    // 设置工具条frame
    _toll.frame = status.toolBarFrame;
    _toll.statusF = status;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
