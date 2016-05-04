//
//  LSStatusFrame.m
//  梁森微博
//
//  Created by 梁森 on 16/4/27.
//  Copyright © 2016年 LS. All rights reserved.
//

#import "LSStatusFrame.h"
// 微博数据模型
#import "LSStatusesModel.h"
@implementation LSStatusFrame
// 将下载的数据中的模型传递过来
- (void)setStatus:(LSStatusesModel *)status
{
    _status = status;
    // 计算原创微博
    [self setUpOriginalViewFrame];
    CGFloat toolBarY = CGRectGetMaxY(_originalViewFrame);
    
    if (status.retweeted_status) {
        
        // 计算转发微博
        [self setUpRetweetViewFrame];
        
        toolBarY = CGRectGetMaxY(_retweetViewFrame);
    }
    // 计算工具条
    CGFloat toolBarX = 0;
    CGFloat toolBarW = CZScreenW;
    CGFloat toolBarH = 35;
    _toolBarFrame = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    
    // 计算cell高度
    _cellHeight = CGRectGetMaxY(_toolBarFrame);
}

#pragma mark - 计算原创微博
- (void)setUpOriginalViewFrame
{
    // 头像
    CGFloat imageX = CZStatusCellMargin;
    CGFloat imageY = imageX;
    CGFloat imageWH = 35;
    _originalIconFrame = CGRectMake(imageX, imageY, imageWH, imageWH);
    
    // 昵称
    CGFloat nameX = CGRectGetMaxX(_originalIconFrame) + CZStatusCellMargin;
    CGFloat nameY = imageY;
    CGSize nameSize = [_status.user.name sizeWithFont:CZNameFont];
    _originalNameFrame = (CGRect){{nameX,nameY},nameSize};
    
    // vip
    if (_status.user.vip) {
        CGFloat vipX = CGRectGetMaxX(_originalNameFrame) + CZStatusCellMargin;
        CGFloat vipY = nameY;
        CGFloat vipWH = 14;
        _originalVipFrame = CGRectMake(vipX, vipY, vipWH, vipWH);
        
    }
    
    // 时间
    
    // 来源
    
    // 正文
    CGFloat textX = imageX;
    CGFloat textY = CGRectGetMaxY(_originalIconFrame) + CZStatusCellMargin;
    CGFloat textW = CZScreenW - 2 * CZStatusCellMargin;
//    NSMutableDictionary * textDic = [NSMutableDictionary dictionary];
//    textDic[NSFontAttributeName] = CZTextFont;
//    CGRect textRect = [_status.text boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesFontLeading attributes:textDic context:nil];
    CGSize textSize = [_status.text sizeWithFont:CZTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _originalTextFrame = (CGRect){{textX,textY},textSize};

    // 配图
    CGFloat originH = CGRectGetMaxY(_originalTextFrame) + CZStatusCellMargin;
    if (_status.pic_urls.count) {
        NSLog(@"原创微博配图数组的个数:%lu", _status.pic_urls.count);
        CGFloat photosX = CZStatusCellMargin;
        CGFloat photosY = CGRectGetMaxY(_originalTextFrame) + CZStatusCellMargin;
        // 计算配图视图的大小（根据图片的数量）
        CGSize photosSize = [self photosSizeWithCount:_status.pic_urls.count];
//        CGSize photosSize = [self photosSizeWithCount:3];
        _originalPhotosFrame = (CGRect){{photosX,photosY},photosSize};
        originH = CGRectGetMaxY(_originalPhotosFrame) + CZStatusCellMargin;
    }
    
    // 原创微博的frame
    CGFloat originX = 0;
    CGFloat originY = 10;
    CGFloat originW = CZScreenW;
    _originalViewFrame = CGRectMake(originX, originY, originW, originH);
    
}
#pragma mark - 计算配图的尺寸
- (CGSize)photosSizeWithCount:(NSUInteger)count
{
    // 获取总列数
    NSUInteger cols = count == 4? 2 : 3;
    // 获取总行数 = (总个数 - 1) / 总列数 + 1
    NSUInteger rols = (count - 1) / cols + 1;
    CGFloat photoWH = 70;
    CGFloat w = cols * photoWH + (cols - 1) * CZStatusCellMargin;
    CGFloat h = rols * photoWH + (rols - 1) * CZStatusCellMargin;
    
    
    return CGSizeMake(w, h);
    
}

#pragma mark - 计算转发微博
- (void)setUpRetweetViewFrame
{
    // 昵称frame
    // 昵称
    CGFloat nameX = CZStatusCellMargin;
    CGFloat nameY = nameX;
    // 注意：一定要是转发微博的用户昵称
    NSMutableDictionary * nameDic = [NSMutableDictionary dictionary];
    nameDic[NSFontAttributeName] = CZNameFont;
    CGSize nameSize = [_status.retweetedName sizeWithAttributes:nameDic];
    _retweetNameFrame = (CGRect){{nameX,nameY},nameSize};
    
    // 正文
//    CGFloat textX = nameX;
    CGFloat textX = 30;
    CGFloat textY = CGRectGetMaxY(_retweetNameFrame) + CZStatusCellMargin;
    
//    CGFloat textW = CZScreenW - 2 * CZStatusCellMargin;
    CGFloat textW = CZScreenW - 30 - 30;
    // 注意：一定要是转发微博的正文
    NSMutableDictionary * textDic = [NSMutableDictionary dictionary];
    textDic[NSFontAttributeName] = CZTextFont;
//    CGSize textSize = [_status.retweeted_status.text sizeWithFont:CZTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    CGRect textRect = [_status.retweeted_status.text boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:textDic context:nil];
    _retweetTextFrame = (CGRect){{textX,textY},textRect.size};
    
    // 配图
    CGFloat retweetH = CGRectGetMaxY(_retweetTextFrame) + CZStatusCellMargin;
    if (_status.retweeted_status.pic_urls.count) {
        NSLog(@"转发配图数组的个数:%lu", _status.retweeted_status.pic_urls.count);
        CGFloat photosX = CZStatusCellMargin;
        CGFloat photosY = CGRectGetMaxY(_retweetTextFrame) + CZStatusCellMargin;
        // 计算配图视图的大小（根据图片的数量）
        CGSize photosSize = [self photosSizeWithCount:_status.retweeted_status.pic_urls.count];
//        NSUInteger a = 3;
//        CGSize photosSize = [self photosSizeWithCount:3];
        _retweetPhotosFrame = (CGRect){{photosX,photosY},photosSize};
        retweetH = CGRectGetMaxY(_retweetPhotosFrame) + CZStatusCellMargin;
    }
    
    // 转发微博的frame
    CGFloat retweetX = 0;
    CGFloat retweetY = CGRectGetMaxY(_originalViewFrame);
    CGFloat retweetW = CZScreenW;
    _retweetViewFrame = CGRectMake(retweetX, retweetY, retweetW, retweetH);
    
}
@end
