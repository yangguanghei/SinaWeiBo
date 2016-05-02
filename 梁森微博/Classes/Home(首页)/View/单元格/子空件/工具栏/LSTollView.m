//
//  LSTollView.m
//  梁森微博
//
//  Created by 梁森 on 16/4/27.
//  Copyright © 2016年 LS. All rights reserved.
//

#import "LSTollView.h"
// 微博模型
#import "LSStatusesModel.h"
// 视图模型
#import "LSStatusFrame.h"
@interface LSTollView()
/**
 *  三个按钮
 */
@property (nonatomic, strong) UIButton * retweet;
@property (nonatomic, strong) UIButton * comment;
@property (nonatomic, strong) UIButton * like;
@property (nonatomic, strong) NSMutableArray * btns;
/**
 *  按钮的分割线
 */
@property (nonatomic, strong) NSMutableArray *divideVs;

@property (nonatomic, strong) LSStatusesModel * status;

@end

@implementation LSTollView

- (NSMutableArray *)btns
{
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}
- (NSMutableArray *)divideVs
{
    if (_divideVs == nil) {
        
        _divideVs = [NSMutableArray array];
    }
    
    return _divideVs;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 添加子控件
        [self setUpChildView];
        self.userInteractionEnabled = YES;
//        self.backgroundColor = [UIColor whiteColor];
        self.image = [UIImage imageWithStretchableName:@"timeline_card_bottom_background"];
    }
    
    return self;
}

- (void)setUpChildView
{
    // 转发
    UIButton * retweet = [self setUpOneButtonWithTitle:@"转发" image:[UIImage imageNamed:@"timeline_icon_retweet"]];
    _retweet = retweet;
    // 评论
    UIButton * comment = [self setUpOneButtonWithTitle:@"评论" image:[UIImage imageNamed:@"timeline_icon_comment"]];
    _comment = comment;
    // 赞
    UIButton * like = [self setUpOneButtonWithTitle:@"赞" image:[UIImage imageNamed:@"timeline_icon_unlike"]];
    _like = like;
    // 添加分隔线
    for (int i = 0; i < 2; i++) {
        UIImageView *divideV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
        [self addSubview:divideV];
        [self.divideVs addObject:divideV];
    }
    
}
- (UIButton *)setUpOneButtonWithTitle:(NSString *)title image:(UIImage *)image
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // 设置字体大小
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    // 设置文字和图片的间距
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    btn.titleLabel.textColor = [UIColor blackColor];
    
    [self addSubview:btn];
    [self.btns addObject:btn];
    return btn;
}

- (void)setStatusF:(LSStatusFrame *)statusF
{
    _statusF = statusF;
    _status = _statusF.status;
    
    // 设置转发标题
    [self setBtn:_retweet title:_status.reposts_count];
    // 设置评论标题
    [self setBtn:_comment title:_status.comments_count];
    // 设置赞
    [self setBtn:_like title:_status.attitudes_count];
    
}
// 设置按钮的标题
- (void)setBtn:(UIButton *)btn title:(int)count
{
    // > 10000 10100 1.2W
    NSString *title = nil;
    if (count) {    // 只有有转发的时候才显示转发数（不会显示转发数0）
        
        if (count > 10000) {    // 当转发数大于一万的时候
            CGFloat floatCount = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1f万",floatCount];
            // 当显示1.0的时候显示1
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }else{ // < 10000
            title = [NSString stringWithFormat:@"%d",count];
        }
        
        
        // 设置转发
        [btn setTitle:title forState:UIControlStateNormal];
    }
}

// 设置子控件的位置
- (void)layoutSubviews
{
    [super layoutSubviews];
    // 设置三个按钮的位置
    for (int i = 0; i < self.btns.count; i ++) {
        UIButton * btn = self.btns[i];
        NSUInteger count = self.btns.count;
        CGFloat w = WIDTH / count;
        CGFloat x = i * w;
        CGFloat y = 0;
        CGFloat h = self.height;
        btn.frame = CGRectMake(x, y, w, h);
    }
    // 分割线的位置
    int i = 1;
    
    for (UIImageView *divide in self.divideVs) {
        UIButton *btn = self.btns[i];
        divide.x = btn.x;
        i++;
    }
}

@end
