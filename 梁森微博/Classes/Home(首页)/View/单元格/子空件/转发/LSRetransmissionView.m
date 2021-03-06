//
//  LSRetransmissionView.m
//  梁森微博
//
//  Created by 梁森 on 16/4/27.
//  Copyright © 2016年 LS. All rights reserved.
//

#import "LSRetransmissionView.h"

#import "LSStatusesModel.h"
#import "LSStatusFrame.h"
// 配图视图
#import "LSPhotosView.h"
@interface LSRetransmissionView()
// 昵称
@property (nonatomic, weak) UILabel *nameView;


// 正文
@property (nonatomic, weak) UILabel *textView;
/**
 *  配图
 */
@property (nonatomic, strong) LSPhotosView * photosView;
@end

@implementation LSRetransmissionView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 添加子控件
        [self setUpChildView];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableName:@"timeline_retweet_background"];
    }
    
    return self;
}

- (void)setUpChildView
{
    // 昵称
    UILabel *nameView = [[UILabel alloc] init];
    nameView.font = CZNameFont;
    nameView.textColor= [UIColor blueColor];
    [self addSubview:nameView];
    _nameView = nameView;
    
    
    // 正文
    UILabel *textView = [[UILabel alloc] init];
    textView.font = CZTextFont;
    textView.numberOfLines = 0;
    [self addSubview:textView];
    _textView = textView;
    
    LSPhotosView * photosView = [[LSPhotosView alloc] init];
    [self addSubview:photosView];
    _photosView = photosView;
}
- (void)setStatusF:(LSStatusFrame *)statusF
{
    _statusF = statusF;
    LSStatusesModel *status = statusF.status;
    // 昵称
    _nameView.frame = statusF.retweetNameFrame;
    _nameView.text = status.retweetedName;
    
    // 正文
    _textView.frame = statusF.retweetTextFrame;
    _textView.text = status.retweeted_status.text;
    
    // 配图
    _photosView.frame = statusF.retweetPhotosFrame;
    _photosView.pic_urls = statusF.status.retweeted_status.pic_urls;
}

@end
