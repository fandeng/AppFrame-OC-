//
//  FindTableViewCell.m
//  DoctorApp
//
//  Created by 樊登 on 2018/3/2.
//  Copyright © 2018年 樊登. All rights reserved.
//

#import "FindTableViewCell.h"

@implementation FindTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.font = kMainFont;
    self.titleLabel.textColor = kTitleColor;
    self.timeLabel.font = kSubtitleFont;
    self.timeLabel.textColor = kSubtitleColor;
    self.authorLabel.font = kSubtitleFont;
    self.authorLabel.textColor = kMainColor;
}

- (void)refreshWithData:(NSDictionary *)dic {
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:dic[@"coverUrl"]] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    self.titleLabel.attributedText = [CommonMethod getAttributedStringWithLineSpace:dic[@"title"] space:5];
    self.authorLabel.text = dic[@"author"];
    self.timeLabel.text = [CommonMethod compareCurrentTime:dic[@"createTime"] timestamp:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
