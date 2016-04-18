//
//  LSAccount.h
//  梁森微博
//
//  Created by pro on 16/4/18.
//  Copyright © 2016年 LS. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 "access_token" = "2.00gXcK_DCjnNmD06b18fabc9gkG8QB";
 "expires_in" = 157679999;
 "remind_in" = 157679999;
 uid = 3031680320;
 */
@interface LSAccount : NSObject<NSCoding>

@property (nonatomic, copy) NSString * access_token;
@property (nonatomic, copy) NSString * expires_in;
@property (nonatomic, copy) NSString * uid;
@property (nonatomic, copy) NSString * remind_in;


@property (nonatomic, strong) NSDate * expiresDate;

- (instancetype)initWithDic:(NSDictionary *)dic;

+ (instancetype)applicationWithDic:(NSDictionary *)dic;
@end
