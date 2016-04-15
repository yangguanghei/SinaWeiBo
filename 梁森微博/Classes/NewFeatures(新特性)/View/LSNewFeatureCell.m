//
//  LSNewFeatureCell.m
//  梁森微博
//
//  Created by pro on 16/4/15.
//  Copyright © 2016年 LS. All rights reserved.
//

#import "LSNewFeatureCell.h"


@implementation LSNewFeatureCell

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        
        [self.contentView addSubview:_imageView];
    }
    
    return _imageView;
}

// 重写set方法
- (void)setImage:(UIImage *)image
{
    _image = image;
    self.imageView.image = image;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
}

@end

