
//
//  UIImage+LSImage.m
//  梁森微博
//
//  Created by pro on 16/4/7.
//  Copyright © 2016年 LS. All rights reserved.
//

#import "UIImage+LSImage.h"

@implementation UIImage (LSImage)

+ (instancetype)imageWithOriginalName:(NSString *)imageName
{
    UIImage * image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
