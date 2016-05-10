//
//  LSStatusTool.m
//  梁森微博
//
//  Created by 梁森 on 16/4/26.
//  Copyright © 2016年 LS. All rights reserved.
//

#import "LSStatusTool.h"

#import "LSHttpTool.h"

#import "LSStatusesModel.h"
// 数据模型
#import "LSStatusParam.h"

#import "LSAccount.h"
#import "LSAccountTool.h"

#import "LSComposeModel.h"
// 上传参数模型
#import "LSUploadParam.h"
@implementation LSStatusTool
// 上传图片
+ (void)composeWithStatus:(NSString *)status image:(UIImage *)image success:(void (^)())success failure:(void (^)(NSError *))failure
{
    LSComposeModel * param = [LSComposeModel param];
    param.status = status;
    
    LSUploadParam * uploadParam = [[LSUploadParam alloc] init];
    uploadParam.data = UIImagePNGRepresentation(image);
    uploadParam.name = @"pic";
    uploadParam.fileName = @"image.png";
    uploadParam.mimeType = @"image/png";
    
    [LSHttpTool upload:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:param.keyValues uploadParam:uploadParam success:^(id responseObject) {
        
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
}


+ (void)PostText:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [LSHttpTool Post:URLString parameters:parameters success:^(id responseObject) {
        
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)newStatusWithSinceId:(NSString *)sinceId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    
    NSString * baseStr = @"https://api.weibo.com/2/statuses/home_timeline.json";
    LSStatusParam * param = [[LSStatusParam alloc] init];
    LSAccount * account = [LSAccountTool account];
    param.access_token = account.access_token;
    
    if (sinceId) {
        param.since_id = sinceId;
    }
    // 模型转字典
    [LSHttpTool GET:baseStr parameters:param.keyValues success:^(id responseObject) { // block是一个参数
        
        NSArray * statusesArr = responseObject[@"statuses"];
        // 将字典数组直接转换成模型数据  李明杰写的第三方
        NSArray * modelArr = [LSStatusesModel objectArrayWithKeyValuesArray:statusesArr];
        if (success) {
            // block传递参数
            success(modelArr);
        }
        
        // 刷新表格
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
}
+ (void)getNewDataWithStr:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [LSHttpTool GET:URLString parameters:parameters success:^(id responseObject) { // block是一个参数
        
        
        NSArray * statusesArr = responseObject[@"statuses"];
        // 将字典数组直接转换成模型数组  李明杰写的第三方
        NSArray * modelArr = [LSStatusesModel objectArrayWithKeyValuesArray:statusesArr];
        
        if (success) {
            // block传递参数
            success(modelArr);
        }
        
        // 刷新表格
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
}

+ (void)getMoreDataWithStr:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [LSHttpTool GET:URLString parameters:parameters success:^(id responseObject) {
        // 获取到微博数据 转换成模型
        // 获取微博字典数组
        NSArray *dictArr = responseObject[@"statuses"];
        // 把字典数组转换成模型数组
        NSArray *statuses = (NSMutableArray *)[LSStatusesModel objectArrayWithKeyValuesArray:dictArr];
        if (success) {
            success(statuses);
        }
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
    
    
}

+ (void)getUserDataWithStr:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [LSHttpTool GET:URLString parameters:parameters success:^(id responseObject) {
        // 获取到微博数据 转换成模型
        // 获取微博字典数组
        NSArray *dictArr = responseObject[@"statuses"];
        // 把字典数组转换成模型数组
        NSArray *statuses = (NSMutableArray *)[LSStatusesModel objectArrayWithKeyValuesArray:dictArr];
        if (success) {
            success(statuses);
        }
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
    
    
}

@end
