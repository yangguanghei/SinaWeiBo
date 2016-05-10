//
//  LSBaseParam.m
//  梁森微博
//
//  Created by 梁森 on 16/5/10.
//  Copyright © 2016年 LS. All rights reserved.
//

#import "LSBaseParam.h"

#import "LSAccount.h"
#import "LSAccountTool.h"
@implementation LSBaseParam

+ (instancetype)param
{
    LSBaseParam * param = [[self alloc] init];
    param.access_token = [LSAccountTool account].access_token;
    return param;
}

@end
