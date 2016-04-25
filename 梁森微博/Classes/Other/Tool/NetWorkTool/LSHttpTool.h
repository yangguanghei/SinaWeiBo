//
//  LSHttpTool.h
//  梁森微博
//
//  Created by 梁森 on 16/4/25.
//  Copyright © 2016年 LS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSHttpTool : NSObject

+ (void)GET:(NSString *)URLString
                        parameters:(id)parameters
                        success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure;

@end
