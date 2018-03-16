//
//  ForumTableViewCell.m
//  DoctorApp
//
//  Created by 樊登 on 2018/3/2.
//  Copyright © 2018年 樊登. All rights reserved.
//

#import "ForumTableViewCell.h"

@implementation ForumTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self lableWithLable:self.nameLabel font:kTitleFont color:kTitleColor];
    [self lableWithLable:self.numLabel font:kSubtitleFont color:kSubtitleColor];
    [self lableWithLable:self.timeLabel font:kCaptionFont color:kCaptionColor];
    [self lableWithLable:self.titleLabel font:kTitleFont color:kTitleColor];
    [self lableWithLable:self.contentLabel font:kSubtitleFont color:kMainColor];
}

- (void)lableWithLable:(UILabel *)label font:(UIFont *)font color:(UIColor *)color {
    label.font = font;
    label.textColor = color;
}

- (void)refreshWithData:(NSDictionary *)dic {
    [self.imgView zy_cornerRadiusRoundingRect];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:dic[@"userLogo"]] placeholderImage:[UIImage imageNamed:@"logo"]];
    [self circleImage];
    self.contentLabel.attributedText = [CommonMethod getAttributedStringWithLineSpace:dic[@"content"] space:5];
    self.contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.nameLabel.text = dic[@"nickname"];
    self.numLabel.text = dic[@"num"];
    self.titleLabel.text = dic[@"title"];
    self.timeLabel.text = [CommonMethod compareCurrentTime:dic[@"createTime"] timestamp:nil];
}

- (void)circleImage {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.imgView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:self.imgView.bounds.size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = self.imgView.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    self.imgView.layer.mask = maskLayer;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
