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
@implementation LSStatusTool

+ (void)getNewDataWithStr:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [LSHttpTool GET:URLString parameters:parameters success:^(id responseObject) { // block是一个参数
        
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

@end
