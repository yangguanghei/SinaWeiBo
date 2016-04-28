//
//  LSInfoCell.h
//  梁森微博
//
//  Created by 梁森 on 16/4/27.
//  Copyright © 2016年 LS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSStatusesModel;
@class LSStatusFrame;
@interface LSInfoCell : UITableViewCell
/**
 *  视图模型属性
 */
@property (nonatomic, strong) LSStatusFrame *status;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
