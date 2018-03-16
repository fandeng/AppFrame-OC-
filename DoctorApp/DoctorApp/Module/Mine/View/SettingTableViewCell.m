//
//  SettingTableViewCell.m
//  DoctorApp
//
//  Created by 樊登 on 2018/3/6.
//  Copyright © 2018年 樊登. All rights reserved.
//

#import "SettingTableViewCell.h"

@implementation SettingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.titleLabel.font = kTitleFont;
    self.titleLabel.textColor = kTitleColor;
    self.contentLabel.font = kMainFont;
    self.contentLabel.textColor = kMainColor;
}

- (void)refreshWithTitle:(NSString *)title content:(NSString *)content row:(NSInteger)row switchValue:(BOOL)switchValue {
    
    self.titleLabel.text = title;
    if (row == 0) {
        self.contentLabel.hidden = YES;
        self.openSwitch.hidden = YES;
    } else if (row == 1) {
        self.contentLabel.hidden = YES;
        self.openSwitch.hidden = NO;
        self.openSwitch.on = switchValue;
    } else {
        self.contentLabel.hidden = NO;
        self.openSwitch.hidden = YES;
        self.contentLabel.text = content;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
