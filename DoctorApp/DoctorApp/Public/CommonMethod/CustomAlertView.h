//
//  CustomAlertView.h
//  DoctorApp
//
//  Created by 樊登 on 2018/3/1.
//  Copyright © 2018年 樊登. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomAlertView : UIView

//index 1：取消 2：确定
@property (nonatomic, copy) void(^customAlertViewClickAction)(NSInteger index, CustomAlertView * alertView);


/**
 确定按钮背景颜色
 */
@property (nonatomic, strong) UIColor *confirmColor;
/**
 确定按钮文本颜色
 */
@property (nonatomic, strong) UIColor *confirmTitleColor;
/**
 取消按钮背景颜色
 */
@property (nonatomic, strong) UIColor *cancalColor;
/**
取消按钮文本颜色
 */
@property (nonatomic, strong) UIColor *cancalTitleColor;
/**
 顶部title栏 背景颜色
 */
@property (nonatomic, strong) UIColor *topColor;
/**
 顶部title栏 文本颜色
 */
@property (nonatomic, strong) UIColor *topTitleColor;

/**
 自定义

 @param title 标题
 @param message 提示内容
 @param confirmTitle 确定按钮文本
 @param cancleTitle 取消按钮文本
 @param isTopTitle 是否有顶部title栏
 @return 空
 */
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message confirmBtn:(NSString *)confirmTitle cancleBtn:(NSString *)cancleTitle isTopTitle:(BOOL)isTopTitle;

- (void)refreshView;

- (void)showCustomAlertView;


@end
