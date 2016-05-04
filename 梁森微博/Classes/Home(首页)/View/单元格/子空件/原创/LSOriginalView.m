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
// 配图视图
#import "LSPhotosView.h"
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

@property (nonatomic, strong) LSPhotosView * photosView;


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
    sourceView.textColor = [UIColor lightGrayColor];
    [self addSubview:sourceView];
    _sourceView = sourceView;
    
    // 正文
    UILabel *textView = [[UILabel alloc] init];
    textView.font = CZTextFont;
    textView.numberOfLines = 0;
    [self addSubview:textView];
    _textView = textView;
    
    // 配图
    LSPhotosView * photosView = [[LSPhotosView alloc] init];
    [self addSubview:photosView];
    _photosView = photosView;
}

- (void)setStatus:(LSStatusFrame *)status   // 该方法每次都会被调用
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
    LSStatusesModel * status = _status.status;
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
    // 时间  该方法只被调用了一次
    CGFloat timeX = _nameView.frame.origin.x;
    CGFloat timeY = CGRectGetMaxY(_nameView.frame) + CZStatusCellMargin * 0.5;
//    CGSize timeSize = [status.created_at sizeWithFont:CZTimeFont];
    NSMutableDictionary * timeDic = [NSMutableDictionary dictionary];
    timeDic[NSFontAttributeName] = CZTimeFont;
    CGSize timeSize = [status.created_at sizeWithAttributes:timeDic];
    _timeView.frame = (CGRect){{timeX,timeY},timeSize};
    
    // 来源
    CGFloat sourceX = CGRectGetMaxX(_timeView.frame) + CZStatusCellMargin;
    CGFloat sourceY = timeY;
    NSMutableDictionary * sourceDic = [NSMutableDictionary dictionary];
    sourceDic[NSFontAttributeName] = CZSourceFont;
    CGSize sourceSize = [status.source sizeWithAttributes:sourceDic];
    _sourceView.frame = (CGRect){{sourceX,sourceY},sourceSize};
    
    // 正文
    _textView.frame = _status.originalTextFrame;
    
    // 配图
    _photosView.frame = _status.originalPhotosFrame;
    
    
}

@end
