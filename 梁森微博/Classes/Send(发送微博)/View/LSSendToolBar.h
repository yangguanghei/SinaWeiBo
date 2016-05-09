//
//  LSSendToolBar.h
//  梁森微博
//
//  Created by 梁森 on 16/5/9.
//  Copyright © 2016年 LS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LSSendToolBarDelegate <NSObject>

- (void)sendToolBarWithBtn:(NSInteger)index;

@end

@interface LSSendToolBar : UIView

@property (nonatomic, assign) id <LSSendToolBarDelegate> delegate;

@end
