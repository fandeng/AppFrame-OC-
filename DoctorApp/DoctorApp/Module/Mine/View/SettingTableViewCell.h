//
//  SettingTableViewCell.h
//  DoctorApp
//
//  Created by 樊登 on 2018/3/6.
//  Copyright © 2018年 樊登. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UISwitch *openSwitch;


/**
 刷新数据

 @param title 标题
 @param content 内容
 @param row 下标
 @param switchValue 开关
 */
- (void)refreshWithTitle:(NSString *)title content:(NSString *)content row:(NSInteger)row switchValue:(BOOL)switchValue;

@end
