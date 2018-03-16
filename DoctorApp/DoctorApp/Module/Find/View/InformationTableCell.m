//
//  InformationTableCell.m
//  DoctorApp
//
//  Created by 樊登 on 2018/3/8.
//  Copyright © 2018年 樊登. All rights reserved.
//

#import "InformationTableCell.h"

@implementation InformationTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.titleLabel.font = kMainFont;
    self.titleLabel.textColor = kTitleColor;
    self.subtitleLabel.font = kCaptionFont;
    self.subtitleLabel.textColor = kSubtitleColor;
    self.contentLabel.font = kSubtitleFont;
    self.contentLabel.textColor = kMainColor;
}

- (void)refreshWithData:(NSDictionary *)dic {
    [self.coverImgView sd_setImageWithURL:[NSURL URLWithString:dic[@"coverUrl"]] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    self.titleLabel.attributedText = [CommonMethod getAttributedStringWithLineSpace:dic[@"title"] space:5];
    self.subtitleLabel.text = [NSString stringWithFormat:@"%@  %@",dic[@"author"],dic[@"createTime"]];
    NSString * content = @"人体表层是会自动分泌出一层油脂的，这层天然油脂对皮肤是有保护作用的，很显然天天洗澡身上还痒，就是因为把这个油脂给洗没了，另外人的表皮最外层是角质层，角质层的作用是保护皮下组织，天天洗澡会将角质层洗薄甚至洗没，皮肤细胞没了保护，其内水分很容易被蒸发，由此令皮肤变得干燥引起瘙痒症状。 天天夏季皮肤出汗多出油多，但仍旧不建议天天洗澡，专家建议是3-5天洗一次，如果身上实在觉得难受，可以毛巾擦拭一下洗澡身上痒该怎么办 　　减少洗澡次数 　　当因天天洗澡而身上发痒时，首先该做的就是减少洗澡次数。";
    self.contentLabel.attributedText = [CommonMethod getAttributedStringWithLineSpace:content space:5];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
