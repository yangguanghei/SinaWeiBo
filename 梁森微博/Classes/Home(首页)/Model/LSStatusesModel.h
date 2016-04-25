//
//  LSStatusesModel.h
//  梁森微博
//
//  Created by 梁森 on 16/4/20.
//  Copyright © 2016年 LS. All rights reserved.
//

#import <Foundation/Foundation.h>
// 用户信息模型
#import "LSUser.h"

// 数据转模型的第三方
#import "MJExtension.h"
@interface LSStatusesModel : NSObject<MJKeyValue>

/**
 *  转发微博
 */
@property (nonatomic, strong) LSStatusesModel * retweeted_status;
/**
 *  用户
 */
@property (nonatomic, strong) LSUser * user;
/**
*  微博创建时间
*/
@property (nonatomic, copy) NSString * created_at;
/**
 *  字符串型的微博ID
 */
@property (nonatomic, copy) NSString *idstr;
/**
 *  微博信息内容
 */
@property (nonatomic, copy) NSString * text;
/**
 *  微博来源
 */
@property (nonatomic, copy) NSString * source;
/**
 *  转发数
 */
@property (nonatomic, assign) int * reposts_count;
/**
 *  评论数
 */
@property (nonatomic, assign) int * comments_count;
/**
 *  表态数
 */
@property (nonatomic, assign) int * attitudes_count;
/**
 *  配图数组
 */
@property (nonatomic, strong) NSArray * pic_ids;


@end
