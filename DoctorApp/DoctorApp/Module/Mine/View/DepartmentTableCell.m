//
//  DepartmentTableCell.m
//  DoctorApp
//
//  Created by 樊登 on 2018/3/8.
//  Copyright © 2018年 樊登. All rights reserved.
//

#import "DepartmentTableCell.h"

@implementation DepartmentTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.font = kMainFont;
    self.titleLabel.textColor = kTitleColor;
    self.bgView.layer.cornerRadius = 8;
    [self.bgView borderForColor:kGrayColor borderWidth:1 borderType:UIBorderSideTypeAll];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
