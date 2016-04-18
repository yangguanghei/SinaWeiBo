//
//  LSAccountTool.h
//  梁森微博
//
//  Created by pro on 16/4/18.
//  Copyright © 2016年 LS. All rights reserved.
//

#import <Foundation/Foundation.h>
//专门处理账号的业务(账号的存储和读取)

@class LSAccount;
@interface LSAccountTool : NSObject

+ (void)saveAccount:(LSAccount *)account;

+ (LSAccount *)account;
@end
