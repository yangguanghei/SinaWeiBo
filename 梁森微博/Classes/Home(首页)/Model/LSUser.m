//
//  LSUser.m
//  梁森微博
//
//  Created by 梁森 on 16/4/20.
//  Copyright © 2016年 LS. All rights reserved.
//

#import "LSUser.h"

@implementation LSUser
- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    _vip = mbtype > 2;
}
@end
