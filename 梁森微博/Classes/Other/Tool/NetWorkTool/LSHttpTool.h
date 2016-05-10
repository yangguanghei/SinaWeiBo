//
//  LSHttpTool.h
//  梁森微博
//
//  Created by 梁森 on 16/4/25.
//  Copyright © 2016年 LS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSUploadParam.h"
@interface LSHttpTool : NSObject
// 上传图片
+ (void)upload:(NSString *)URLString
    parameters:(id)parameters uploadParam:(LSUploadParam *)uploadPara
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;

+ (void)GET:(NSString *)URLString
                        parameters:(id)parameters
                        success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure;

+ (void)Post:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;

@end
