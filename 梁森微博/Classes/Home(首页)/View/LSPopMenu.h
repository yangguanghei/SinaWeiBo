//
//  LSPopMenu.h
//  梁森微博
//
//  Created by pro on 16/4/8.
//  Copyright © 2016年 LS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSPopMenu : UIImageView

@property (nonatomic, strong) UIView * contenView;

// 展示菜单，此菜单的大小是不固定的，因此需要传递rect
+ (instancetype)showWithRect:(CGRect)rect;

+ (void)hide;

@end
