//
//  LSParamers.h
//  梁森微博
//
//  Created by 梁森 on 16/4/26.
//  Copyright © 2016年 LS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSParamers : NSObject
/**
 *  AppKey
 */
@property (nonatomic, copy) NSString *client_id;
/**
 *  AppSecret
 */
@property (nonatomic, copy) NSString *client_secret;
/**
 *  请求的类型,填写authorization_code
 */
@property (nonatomic, copy) NSString *grant_type;
/**
 *  调用authorize获得的code值
 */
@property (nonatomic, copy) NSString *code;
/**
 *  回调地址
 */
@property (nonatomic, copy) NSString *redirect_uri;
@end
