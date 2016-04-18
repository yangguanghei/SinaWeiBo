//
//  LSAccount.m
//  梁森微博
//
//  Created by pro on 16/4/18.
//  Copyright © 2016年 LS. All rights reserved.
//

#import "LSAccount.h"

#define LSAccessToken @"token"
#define LSExpiresIn @"expires"
#define LSUid @"uid"
#define LSExpireDate @"expireDate"


@implementation LSAccount

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype)applicationWithDic:(NSDictionary *)dic
{
    LSAccount * account = [[self alloc] initWithDic:dic];
    return account;
}

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_access_token forKey:LSAccessToken];
    [aCoder encodeObject:_expires_in forKey:LSExpiresIn];
    [aCoder encodeObject:_uid forKey:LSUid];
    [aCoder encodeObject:_expiresDate forKey:LSExpireDate];
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        // 解档之后保存到属性中
        _access_token = [aDecoder decodeObjectForKey:LSAccessToken];
        _expires_in = [aDecoder decodeObjectForKey:LSExpiresIn];
        _uid = [aDecoder decodeObjectForKey:LSUid];
        _expiresDate = [aDecoder decodeObjectForKey:LSExpireDate];
    }
    return self;
}
// 重写set方法，设置过期时间
- (void)setExpires_in:(NSString *)expires_in
{
    _expires_in = expires_in;
    // 过期时间等于当前时间＋过期时间长度
    _expiresDate = [NSDate dateWithTimeIntervalSinceNow:[_expires_in longLongValue]];
}

@end
