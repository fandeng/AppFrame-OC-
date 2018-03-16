//
//  CustomAlertInputView.m
//  DoctorApp
//
//  Created by 樊登 on 2018/3/8.
//  Copyright © 2018年 樊登. All rights reserved.
//

#import "CustomAlertInputView.h"

//宽
#define AlertWidth ScreenWidth-40

@interface CustomAlertInputView()<UITextFieldDelegate>

//弹窗
@property (nonatomic, strong) UIView *alertView;
//顶部栏
@property (nonatomic, strong) UIView *topView;
//顶部文本
@property (nonatomic, strong) UILabel *topLabel;
//内容
@property (nonatomic, strong) UITextField *textField;
//确认按钮
@property (nonatomic, strong) UIButton *confirmBtn;


@end

@implementation CustomAlertInputView

- (instancetype)initWithTitle:(NSString *)title inputText:(NSString *)inputText {
    
    if (self == [super init]) {
        
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        self.alertView = [[UIView alloc] init];
        self.alertView.backgroundColor = [UIColor whiteColor];
        self.alertView.frame = CGRectMake(0, 0, AlertWidth, 100);
        self.alertView.layer.position = self.center;

        self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AlertWidth, 50)];
        self.topView.backgroundColor = kThemeColor;
        self.topLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, AlertWidth-20, 20)];
        self.topLabel.text = title;
        self.topLabel.textColor = [UIColor whiteColor];
        self.topLabel.textAlignment = NSTextAlignmentCenter;
        self.topLabel.font = kNavFont(16);
        [self.topView addSubview:self.topLabel];
        [self.alertView addSubview:self.topView];
        
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.topView.frame)+15, AlertWidth-20, 35)];
        self.textField.font = kMainFont;
        self.textField.delegate = self;
        self.textField.borderStyle = UITextBorderStyleRoundedRect;
        self.textField.placeholder = [NSString stringWithFormat:@"请输入%@",title];
        self.textField.text = inputText;
        [self.alertView addSubview:self.textField];
        
        self.confirmBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        self.confirmBtn.frame = CGRectMake(10, CGRectGetMaxY(self.textField.frame)+20, AlertWidth-20, 40);
        [self.confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [self.confirmBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
        self.confirmBtn.layer.cornerRadius = 8;
        self.confirmBtn.clipsToBounds = YES;
        [self.alertView addSubview:self.confirmBtn];
        
        //计算高度
        CGFloat alertHeight = CGRectGetMaxY(self.confirmBtn.frame)+10;
        self.alertView.frame = CGRectMake(0, 0, AlertWidth, alertHeight);
        self.alertView.layer.position = self.center;
        self.alertView.layer.cornerRadius = 5.0;
        self.alertView.clipsToBounds = YES;
        [self addSubview:self.alertView];
    }
    
    return self;
}

- (void)refreshView {
    [self.confirmBtn setBackgroundColor:kThemeColor];
    [self.confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

#pragma mark - 弹出 -
- (void)showCustomAlertView {
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
    [self creatShowAnimation];
}

- (void)creatShowAnimation {
    self.alertView.layer.position = self.center;
    self.alertView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
    }];
}

#pragma mark - 回调
- (void)buttonEvent:(UIButton *)sender {
    !self.customAlertInputViewAction?:self.customAlertInputViewAction(self.textField.text, self);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
