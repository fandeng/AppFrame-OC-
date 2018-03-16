//
//  CustomAlertView.m
//  DoctorApp
//
//  Created by 樊登 on 2018/3/1.
//  Copyright © 2018年 樊登. All rights reserved.
//

#import "CustomAlertView.h"

//宽
#define AlertWidth 280
///栏目间的距离
#define CustomSpace 10.0

@interface CustomAlertView()

//弹窗
@property (nonatomic, strong) UIView *alertView;
//顶部栏
@property (nonatomic, strong) UIView *topView;
//顶部文本
@property (nonatomic, strong) UILabel *topLabel;
//title
@property (nonatomic, strong) UILabel *titleLabel;
//内容
@property (nonatomic, strong) UILabel *msgLabel;
//确认按钮
@property (nonatomic, strong) UIButton *confirmBtn;
//取消按钮
@property (nonatomic, strong) UIButton *cancleBtn;
//横线线
@property (nonatomic, strong) UIView *lineView;
//竖线
@property (nonatomic, strong) UIView *verLineView;

@property (nonatomic, assign) BOOL isTop;

@end

@implementation CustomAlertView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message confirmBtn:(NSString *)confirmTitle cancleBtn:(NSString *)cancleTitle isTopTitle:(BOOL)isTopTitle {
    
    if (self == [super init]) {
        
        self.frame = [UIScreen mainScreen].bounds;
        self.isTop = isTopTitle;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        self.alertView = [[UIView alloc] init];
        self.alertView.backgroundColor = [UIColor whiteColor];
        self.alertView.frame = CGRectMake(0, 0, AlertWidth, 100);
        self.alertView.layer.position = self.center;
        if (isTopTitle == NO && title != nil && title.length > 0) {
            
            self.titleLabel = [self GetAdaptiveLable:CGRectMake(2*CustomSpace, 2*CustomSpace, AlertWidth-4*CustomSpace, 20) AndText:title andIsTitle:YES];
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            
            [self.alertView addSubview:self.titleLabel];
            
            CGFloat titleW = self.titleLabel.bounds.size.width;
            CGFloat titleH = self.titleLabel.bounds.size.height;
            
            self.titleLabel.frame = CGRectMake((AlertWidth-titleW)/2, 2*CustomSpace, titleW, titleH);
            
        } else {
            self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AlertWidth, 50)];
            self.topLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, AlertWidth-20, 20)];
            self.topLabel.text = title;
            self.topLabel.textAlignment = NSTextAlignmentCenter;
            self.topLabel.font = kTitleFont;
            [self.topView addSubview:self.topLabel];
            [self.alertView addSubview:self.topView];
        }
        CGFloat y = isTopTitle?CGRectGetMaxY(self.topView.frame):CGRectGetMaxY(self.titleLabel.frame);
        if (message != nil || message.length > 0) {
            self.msgLabel = [self GetAdaptiveLable:CGRectMake(CustomSpace, y+CustomSpace, AlertWidth-2*CustomSpace, 20) AndText:message andIsTitle:NO];
            self.msgLabel.textAlignment = NSTextAlignmentCenter;
            
            [self.alertView addSubview:self.msgLabel];
            
            CGFloat msgW = self.msgLabel.bounds.size.width;
            CGFloat msgH = self.msgLabel.bounds.size.height;
            
            if (isTopTitle) {
                self.msgLabel.frame = CGRectMake((AlertWidth-msgW)/2, y+CustomSpace, msgW, msgH);
            } else {
                self.msgLabel.frame = self.titleLabel?CGRectMake((AlertWidth-msgW)/2, y+CustomSpace, msgW, msgH):CGRectMake((AlertWidth-msgW)/2, 2*CustomSpace, msgW, msgH);
            }
        }
        
        self.lineView = [[UIView alloc] init];
        self.lineView.frame = self.msgLabel?CGRectMake(0, CGRectGetMaxY(self.msgLabel.frame)+2*CustomSpace, AlertWidth, 1):CGRectMake(0, y+2*CustomSpace, AlertWidth, 1);
        self.lineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
        [self.alertView addSubview:self.lineView];
        
        //两个按钮
        if (cancleTitle && confirmTitle) {
            
            self.cancleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            self.cancleBtn.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), (AlertWidth-1)/2, 40);
            [self.cancleBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateNormal];
            [self.cancleBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
            [self.cancleBtn setTitle:cancleTitle forState:UIControlStateNormal];
            //[self.cancleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            self.cancleBtn.tag = 1;
            [self.cancleBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.cancleBtn.bounds byRoundingCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.cancleBtn.bounds;
            maskLayer.path = maskPath.CGPath;
            self.cancleBtn.layer.mask = maskLayer;
            
            [self.alertView addSubview:self.cancleBtn];
        }
        
        if (cancleTitle && confirmTitle) {
            self.verLineView = [[UIView alloc] init];
            self.verLineView.frame = CGRectMake(CGRectGetMaxX(self.cancleBtn.frame), CGRectGetMaxY(self.lineView.frame), 1, 40);
            self.verLineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
            [self.alertView addSubview:self.verLineView];
        }
        
        if(confirmTitle && cancleTitle){
            
            self.confirmBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            self.confirmBtn.frame = CGRectMake(CGRectGetMaxX(self.verLineView.frame), CGRectGetMaxY(self.lineView.frame), (AlertWidth-1)/2+1, 40);
            [self.confirmBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateNormal];
            [self.confirmBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
            [self.confirmBtn setTitle:confirmTitle forState:UIControlStateNormal];
            //[self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.confirmBtn.tag = 2;
            [self.confirmBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.confirmBtn.bounds byRoundingCorners:UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.confirmBtn.bounds;
            maskLayer.path = maskPath.CGPath;
            self.confirmBtn.layer.mask = maskLayer;
            
            [self.alertView addSubview:self.confirmBtn];
            
        }
        
        //只有取消按钮
        if (cancleTitle && !confirmTitle) {
            
            self.cancleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            self.cancleBtn.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), AlertWidth, 40);
            [self.cancleBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateNormal];
            [self.cancleBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
            [self.cancleBtn setTitle:cancleTitle forState:UIControlStateNormal];
            //[self.cancleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            self.cancleBtn.tag = 1;
            [self.cancleBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.cancleBtn.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.cancleBtn.bounds;
            maskLayer.path = maskPath.CGPath;
            self.cancleBtn.layer.mask = maskLayer;
            
            [self.alertView addSubview:self.cancleBtn];
        }
        
        //只有确定按钮
        if(confirmTitle && !cancleTitle){
            
            self.confirmBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            self.confirmBtn.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), AlertWidth, 40);
            [self.confirmBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateNormal];
            [self.confirmBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
            [self.confirmBtn setTitle:confirmTitle forState:UIControlStateNormal];
            //[self.sureBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            self.confirmBtn.tag = 2;
            [self.confirmBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.confirmBtn.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.confirmBtn.bounds;
            maskLayer.path = maskPath.CGPath;
            self.confirmBtn.layer.mask = maskLayer;
            
            [self.alertView addSubview:self.confirmBtn];
            
        }
        
        //计算高度
        CGFloat alertHeight = cancleTitle?CGRectGetMaxY(self.cancleBtn.frame):CGRectGetMaxY(self.confirmBtn.frame);
        self.alertView.frame = CGRectMake(0, 0, AlertWidth, alertHeight);
        self.alertView.layer.position = self.center;
        self.alertView.layer.cornerRadius = 5.0;
        self.alertView.clipsToBounds = YES;
        [self addSubview:self.alertView];
    }
    
    return self;
}
- (void)refreshView {
    if (self.isTop) {
        self.topView.backgroundColor = self.topColor;
        self.topLabel.textColor = self.topTitleColor;
    }
    [self.confirmBtn setBackgroundColor:self.confirmColor];
    [self.confirmBtn setTitleColor:self.confirmTitleColor forState:UIControlStateNormal];
    [self.cancleBtn setBackgroundColor:self.cancalColor];
    [self.cancleBtn setTitleColor:self.cancalTitleColor forState:UIControlStateNormal];
    [self.lineView removeFromSuperview];
    [self.verLineView removeFromSuperview];
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
    !self.customAlertViewClickAction?:self.customAlertViewClickAction(sender.tag, self);
}

-(UILabel *)GetAdaptiveLable:(CGRect)rect AndText:(NSString *)contentStr andIsTitle:(BOOL)isTitle {
    
    UILabel *contentLbl = [[UILabel alloc] initWithFrame:rect];
    contentLbl.numberOfLines = 0;
    contentLbl.text = contentStr;
    contentLbl.textAlignment = NSTextAlignmentCenter;
    if (isTitle) {
        contentLbl.font = [UIFont boldSystemFontOfSize:16.0];
    }else{
        contentLbl.font = [UIFont systemFontOfSize:14.0];
    }
    
    NSMutableAttributedString *mAttrStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
    NSMutableParagraphStyle *mParaStyle = [[NSMutableParagraphStyle alloc] init];
    mParaStyle.lineBreakMode = NSLineBreakByCharWrapping;
    [mParaStyle setLineSpacing:3.0];
    [mAttrStr addAttribute:NSParagraphStyleAttributeName value:mParaStyle range:NSMakeRange(0,[contentStr length])];
    [contentLbl setAttributedText:mAttrStr];
    [contentLbl sizeToFit];
    
    return contentLbl;
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


@end
