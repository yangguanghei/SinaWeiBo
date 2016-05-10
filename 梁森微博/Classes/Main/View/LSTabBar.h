//
//  LSTabBar.h
//  梁森微博
//
//  Created by pro on 16/4/7.
//  Copyright © 2016年 LS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LSTabBarDelegate <NSObject>

- (void)sendMessageAction;

@end

@interface LSTabBar : UITabBar

//@property (nonatomic, strong) UIButton * plusBtn;

@property (nonatomic, weak) id<LSTabBarDelegate> sendDelegate;

@end
