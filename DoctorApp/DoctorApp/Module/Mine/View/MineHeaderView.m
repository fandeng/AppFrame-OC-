//
//  MineHeaderView.m
//  DoctorApp
//
//  Created by 樊登 on 2018/3/5.
//  Copyright © 2018年 樊登. All rights reserved.
//

#import "MineHeaderView.h"

@implementation MineHeaderView

- (void)refreshWithHeader:(NSString *)url name:(NSString *)name {
    self.bgImgView.image = [CommonMethod imageWithColor:[UIColor colorWithHex:@"#5e82a4"]];
    self.nameLabel.font = kTitleFont;
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.text = name;
    [self.imgView zy_cornerRadiusRoundingRect];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"logo"]];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickUserInfoAction)];
    self.imgView.userInteractionEnabled = YES;
    [self.imgView addGestureRecognizer:tap];
}

- (void)clickUserInfoAction {
    !self.clickMineHeaderViewAction?:self.clickMineHeaderViewAction(3, self);
}

- (IBAction)clickLeftAction:(id)sender {
    !self.clickMineHeaderViewAction?:self.clickMineHeaderViewAction(1, self);
}

- (IBAction)clickSetAction:(id)sender {
    !self.clickMineHeaderViewAction?:self.clickMineHeaderViewAction(2, self);
}


@end
