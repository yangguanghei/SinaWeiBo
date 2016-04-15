//
//  LSSearchBar.m
//  梁森微博
//
//  Created by pro on 16/4/8.
//  Copyright © 2016年 LS. All rights reserved.
//

#import "LSSearchBar.h"

#import "UIImage+LSImage.h"
#import "UIView+Frame.h"
@implementation LSSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.font = [UIFont systemFontOfSize:13];
        
//        self.backgroundColor = [UIColor whiteColor];
        // 防止背景图片的拉伸
        self.background = [UIImage imageWithStretchableName:@"searchbar_textfield_background"];
        
        // 设置左边的view
        // initWithImage:默认UIImageView的尺寸跟图片一样
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        // 拉长宽度，图片居中显示
        imageV.width += 10;
        // imageView上的图片居中显示
        imageV.contentMode = UIViewContentModeCenter;
        self.leftView = imageV;
        // 一定要设置，想要显示搜索框左边的视图，一定要设置左边视图的模式
        self.leftViewMode = UITextFieldViewModeAlways;
        
    }
    return self;
}
@end
