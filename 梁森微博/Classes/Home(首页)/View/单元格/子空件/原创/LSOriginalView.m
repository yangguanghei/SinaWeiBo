//
//  LSOriginalView.m
//  梁森微博
//
//  Created by 梁森 on 16/4/27.
//  Copyright © 2016年 LS. All rights reserved.
//

#import "LSOriginalView.h"
// 视图模型
#import "LSStatusFrame.h"
// 模型
#import "LSStatusesModel.h"

// 下载图片第三方
#import "UIImageView+WebCache.h"
@interface LSOriginalView()
// 头像
@property (nonatomic, weak) UIImageView *iconView;


// 昵称
@property (nonatomic, weak) UILabel *nameView;


// vip
@property (nonatomic, weak) UIImageView *vipView;


// 时间
@property (nonatomic, weak) UILabel *timeView;

// 来源
@property (nonatomic, weak) UILabel *sourceView;


// 正文
@property (nonatomic, weak) UILabel *textView;
@end

@implementation LSOriginalView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 添加子控件
        [self setUpChildView];
        self.userInteractionEnabled = YES;
        // 设置原创微博的背景色
        self.image = [UIImage imageWithStretchableName:@"timeline_card_top_background"];
    }
    
    return self;
}

- (void)setUpChildView
{
    // 头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    _iconView = iconView;
    
    // 昵称
    UILabel *nameView = [[UILabel alloc] init];
    nameView.font = CZNameFont;
    [self addSubview:nameView];
    _nameView = nameView;
    
    // vip
    UIImageView *vipView = [[UIImageView alloc] init];
    [self addSubview:vipView];
    _vipView = vipView;
    
    // 时间
    UILabel *timeView = [[UILabel alloc] init];
    timeView.font = CZTimeFont;
    timeView.textColor = [UIColor orangeColor];
    [self addSubview:timeView];
    _timeView = timeView;
    
    // 来源
    UILabel *sourceView = [[UILabel alloc] init];
    sourceView.font = CZSourceFont;
    [self addSubview:sourceView];
    _sourceView = sourceView;
    
    // 正文
    UILabel *textView = [[UILabel alloc] init];
    textView.font = CZTextFont;
    textView.numberOfLines = 0;
    [self addSubview:textView];
    _textView = textView;
}

- (void)setStatus:(LSStatusFrame *)status
{
    _status = status;
    // 设置frame
    [self setUpFrame];
    // 设置data
    [self setUpData];
}

#pragma mark ------ 设置data
- (void)setUpData
{
    LSStatusesModel * status = _status.status;
    // 头像
    [_iconView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    // 昵称
    if (status.user.vip) {
        _nameView.textColor = [UIColor redColor];
    }else{
        _nameView.textColor = [UIColor blackColor];
    }
    _nameView.text = status.user.name;
    
    // vip
    NSString *imageName = [NSString stringWithFormat:@"common_icon_membership_level%d",status.user.mbrank];
    UIImage *image = [UIImage imageNamed:imageName];
    
    _vipView.image = image;
    
    // 时间
    _timeView.text = status.created_at;
    
    // 来源
    
    _sourceView.text = status.source;
    
    // 正文
    _textView.text = status.text;
}
#pragma mark ------ 设置frame
- (void)setUpFrame
{
    // 头像
    _iconView.frame = _status.originalIconFrame;
    
    // 昵称
    _nameView.frame = _status.originalNameFrame;
    
    // vip
    if (_status.status.user.vip) { // 是vip
        _vipView.hidden = NO;
        _vipView.frame = _status.originalVipFrame;
    }else{
        _vipView.hidden = YES;
    }
    // 时间
    _timeView.frame = _status.originalTimeFrame;
    
    // 来源
    _sourceView.frame = _status.originalSourceFrame;
    
    // 正文
    _textView.frame = _status.originalTextFrame;
    
    
}

@end
