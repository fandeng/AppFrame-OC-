//
//  CardViewController.m
//  DoctorApp
//
//  Created by 樊登 on 2018/3/8.
//  Copyright © 2018年 樊登. All rights reserved.
//

#import "CardViewController.h"

@interface CardViewController ()

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIImageView *userLogoImgView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *codeImgView;

@end

@implementation CardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人名片";
    [self createBackButton];
    [self labelWithLabel:self.nameLabel font:kMainFont color:kTitleColor];
    [self labelWithLabel:self.titleLabel font:kMainFont color:kMainColor];
    [self labelWithLabel:self.subtitleLabel font:kMainFont color:kTitleColor];
    self.bgView.layer.cornerRadius = 8;
    self.bgView.layer.borderColor = kGrayColor.CGColor;
    self.bgView.layer.borderWidth = 1;
    [self.userLogoImgView zy_cornerRadiusRoundingRect];
    [self.userLogoImgView sd_setImageWithURL:[NSURL URLWithString:@"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3835665625,849187119&fm=27&gp=0.jpg"] placeholderImage:[UIImage imageNamed:@"logo"]];
    [self.codeImgView sd_setImageWithURL:[NSURL URLWithString:@"https://qr.api.cli.im/qr?data=%25E6%2592%2592%25E5%25A5%25A5%25E6%2592%2592%25E6%2589%2580&level=H&transparent=false&bgcolor=%23ffffff&forecolor=%23000000&blockpixel=12&marginblock=1&logourl=&size=280&kid=cliim&key=fad4d24930bcbad89dc40df6f17d3577"] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    self.nameLabel.text = @"陈医生";
    self.titleLabel.attributedText = [CommonMethod getAttributedStringWithLineSpace:@"双方都  |  副主任 \n是带饭佛挡杀佛" space:5];
}

- (void)labelWithLabel:(UILabel *)label font:(UIFont *)font color:(UIColor *)color {
    label.font = font;
    label.textColor = color;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
