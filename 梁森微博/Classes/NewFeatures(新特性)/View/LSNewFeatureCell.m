//
//  LSNewFeatureCell.m
//  梁森微博
//
//  Created by pro on 16/4/15.
//  Copyright © 2016年 LS. All rights reserved.
//

#import "LSNewFeatureCell.h"
// 根视图控制器
#import "LSTabBarController.h"
@implementation LSNewFeatureCell

- (UIButton *)startBtn
{
    if (!_startBtn) {
        _startBtn = [[UIButton alloc] init];
        [_startBtn setTitle:@"开始" forState:UIControlStateNormal];
        [_startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
        [_startBtn sizeToFit];
        _startBtn.backgroundColor = [UIColor redColor];
        [_startBtn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_startBtn];
    }
    return _startBtn;
}

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
    
    self.startBtn.center = CGPointMake(self.width * 0.5, self.height * 0.9);
    
}
// 开始按钮点击事件
- (void)start
{
    LSTabBarController * rootVC = [[LSTabBarController alloc] init];
    LSKeyWindow.rootViewController = rootVC;
}

@end

