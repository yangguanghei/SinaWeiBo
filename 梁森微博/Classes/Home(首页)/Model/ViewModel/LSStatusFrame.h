//
//  LSStatusFrame.h
//  梁森微博
//
//  Created by 梁森 on 16/4/27.
//  Copyright © 2016年 LS. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LSStatusesModel;
@interface LSStatusFrame : NSObject

/**
 *  微博数据
 */
@property (nonatomic, strong) LSStatusesModel *status;

/**
 *  原创微博frame
 */
@property (nonatomic, assign) CGRect originalViewFrame;

/**   ******原创微博子控件frame**** */
/**
 *  头像Frame
 */
@property (nonatomic, assign) CGRect originalIconFrame;

/**
 *  昵称Frame
 */
@property (nonatomic, assign) CGRect originalNameFrame;

/**
 *  vipFrame
 */
@property (nonatomic, assign) CGRect originalVipFrame;

/**
 *  时间Frame
 */
@property (nonatomic, assign) CGRect originalTimeFrame;

/**
 *  来源Frame
 */
@property (nonatomic, assign) CGRect originalSourceFrame;

/**
 *  正文Frame
 */
@property (nonatomic, assign) CGRect originalTextFrame;




/**
 *  转发微博frame
 */
@property (nonatomic, assign) CGRect retweetViewFrame;

/**   ******转发微博子控件frame**** */
/**
 *  昵称Frame
 */
@property (nonatomic, assign) CGRect retweetNameFrame;

/**
 *  正文Frame
 */
@property (nonatomic, assign) CGRect retweetTextFrame;

/**
 *  工具条frame
 */
@property (nonatomic, assign) CGRect toolBarFrame;

/**
 *  cell的高度
 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
