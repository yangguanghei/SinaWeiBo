//
//  LSStatusTool.h
//  梁森微博
//
//  Created by 梁森 on 16/4/26.
//  Copyright © 2016年 LS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSStatusTool : NSObject

+ (void)getNewDataWithStr:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure;
/**
 *  获取新的微博数据
 *
 *  @param sinceId <#sinceId description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+ (void)newStatusWithSinceId:(NSString *)sinceId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure;

+ (void)getMoreDataWithStr:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure;
/**
 *  获取用户信息
 *
 *  @param URLString  <#URLString description#>
 *  @param parameters <#parameters description#>
 *  @param success    <#success description#>
 *  @param failure    <#failure description#>
 */
+ (void)getUserDataWithStr:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure;

+ (void)PostText:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure;

@end
