//
//  LSPhotoView.m
//  梁森微博
//
//  Created by 梁森 on 16/5/6.
//  Copyright © 2016年 LS. All rights reserved.
//

#import "LSPhotoView.h"
#import "LSPhonto.h"

#import "UIImageView+WebCache.h"

@interface LSPhotoView()

@property (nonatomic, strong) UIImageView * gifView;

@end
@implementation LSPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.userInteractionEnabled = YES;
        // 裁剪图片，超出控件的部分裁剪掉
        self.clipsToBounds = YES;
        
        // 添加动态图标识
        UIImageView * gifView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif"]]; // 和图片大小一样
        [self addSubview:gifView];
        _gifView = gifView;
    }
    return self;
}

- (void)setPhoto:(LSPhonto *)photo
{
    _photo = photo;
    [self sd_setImageWithURL:photo.thumbnail_pic placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    // 判断下是否显示gif
    NSString *urlStr = photo.thumbnail_pic.absoluteString;
    if ([urlStr hasSuffix:@".gif"]) {
        self.gifView.hidden = NO;
    }else{
        self.gifView.hidden = YES;
    }
}
// 对子视图进行布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}

@end
