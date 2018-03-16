//
//  MineInfoTableCell.m
//  DoctorApp
//
//  Created by 樊登 on 2018/3/8.
//  Copyright © 2018年 樊登. All rights reserved.
//

#import "MineInfoTableCell.h"

@implementation MineInfoTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.font = kMainFont;
    self.titleLabel.textColor = kTitleColor;
    self.subtitleLabel.font = kSubtitleFont;
    self.subtitleLabel.textColor = kMainColor;
}

- (void)refreshWithData:(NSString *)title subtitle:(NSString *)subtitle url:(NSString *)url {
    self.titleLabel.text = title;
    if (url == nil) {
        self.subtitleLabel.text = subtitle;
        self.subtitleLabel.hidden = NO;
        self.userLogoImgView.hidden = YES;
    } else {
        self.subtitleLabel.hidden = YES;
        self.userLogoImgView.hidden = NO;
        [self.userLogoImgView zy_cornerRadiusRoundingRect];
        [self.userLogoImgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"logo"]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
