//
//  LSStatusesModel.m
//  梁森微博
//
//  Created by 梁森 on 16/4/20.
//  Copyright © 2016年 LS. All rights reserved.
//

#import "LSStatusesModel.h"

#import "LSPhonto.h"
// 时间类分类
#import "NSDate+MJ.h"
@implementation LSStatusesModel
// 实现这个方法，就会自动把数组中的字典转换成对应的模型
+ (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls":[LSPhonto class]};
}
// 重写时间的get方法
- (NSString *)created_at
{
    // Tue Mar 10 17:32:22 +0800 2015
    // 字符串转换NSDate
//    _created_at = @"Tue Mar 11 17:48:24 +0800 2015";
    // 日期格式字符串
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
    NSDate *created_at = [fmt dateFromString:_created_at];
    
    if ([created_at isThisYear]) { // 今年
        
        if ([created_at isToday]) { // 今天
            
            // 计算跟当前时间差距
            NSDateComponents *cmp = [created_at deltaWithNow];
            
//            NSLog(@"%ld--%ld--%ld",cmp.hour,cmp.minute,cmp.second);
            
            if (cmp.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时之前",cmp.hour];
            }else if (cmp.minute > 1){
                return [NSString stringWithFormat:@"%ld分钟之前",cmp.minute];
            }else{
                return @"刚刚";
            }
            
        }else if ([created_at isYesterday]){ // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return  [fmt stringFromDate:created_at];
            
        }else{ // 前天
            fmt.dateFormat = @"MM-dd HH:mm";
            return  [fmt stringFromDate:created_at];
        }
        
        
        
    }else{ // 不是今年
        
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        
        return [fmt stringFromDate:created_at];
        
    }
    return _created_at;
}

//- (NSString *)source
//{
//    NSRange range = [_source rangeOfString:@">"];
//    _source = [_source substringFromIndex:range.location + range.length];
//    //    NSLog(@"range的长度：%lu", range.length);
//    range = [_source rangeOfString:@"<"];
//    _source = [_source substringToIndex:range.location];
//    _source = [NSString stringWithFormat:@"来自%@",_source];
//    
//    return _source;
//}
// 重写来源的set方法，
- (void)setSource:(NSString *)source
{
    NSRange range = [source rangeOfString:@">"];
    source = [source substringFromIndex:range.location + range.length];
//    NSLog(@"range的长度：%lu", range.length);
    range = [source rangeOfString:@"<"];
    source = [source substringToIndex:range.location];
    source = [NSString stringWithFormat:@"来自%@",source];
    
    _source = source;
}

// 重写转发微博的set方法
- (void)setRetweeted_status:(LSStatusesModel *)retweeted_status
{
    _retweeted_status = retweeted_status;
    _retweetedName = [NSString stringWithFormat:@"@%@",retweeted_status.user.name];
}


@end
