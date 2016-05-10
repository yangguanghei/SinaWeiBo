//
//  LSBaseParam.h
//  梁森微博
//
//  Created by 梁森 on 16/5/10.
//  Copyright © 2016年 LS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSBaseParam : NSObject
/**
 *  采用OAuth授权方式为必选参数，访问命令牌
 */
@property (nonatomic, copy) NSString * access_token;

+ (instancetype)param;


@end
