//
//  LSStatusesModel.m
//  梁森微博
//
//  Created by 梁森 on 16/4/20.
//  Copyright © 2016年 LS. All rights reserved.
//

#import "LSStatusesModel.h"

#import "LSPhonto.h"

@implementation LSStatusesModel
// 实现这个方法，就会自动把数组中的字典转换成对应的模型
+ (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls":[LSPhonto class]};
}

@end
