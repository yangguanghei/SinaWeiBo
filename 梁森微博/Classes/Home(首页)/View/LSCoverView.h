//
//  LSCoverView.h
//  梁森微博
//
//  Created by pro on 16/4/8.
//  Copyright © 2016年 LS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CoverViewClickDeleagate <NSObject>

-(void)didClickCoverView;

@end

@interface LSCoverView : UIView
// 显示蒙板
+ (instancetype)show;

@property (nonatomic, strong) id <CoverViewClickDeleagate> delegate;

@end
