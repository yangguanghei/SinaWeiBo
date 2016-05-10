//
//  LSUploadParam.h
//  梁森微博
//
//  Created by 梁森 on 16/5/10.
//  Copyright © 2016年 LS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSUploadParam : NSObject
/**
 *  上传文件的二进制数据
 */
@property (nonatomic, strong) NSData * data;
/**
 *  上传的参数名称
 */
@property (nonatomic, copy) NSString * name;
/**
 *  上传到服务器的文件名称
 */
@property (nonatomic, copy) NSString * fileName;
/**
 *  上传文件的类型
 */
@property (nonatomic, copy) NSString * mimeType;
@end
