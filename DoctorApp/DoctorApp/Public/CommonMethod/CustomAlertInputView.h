//
//  CustomAlertInputView.h
//  DoctorApp
//
//  Created by 樊登 on 2018/3/8.
//  Copyright © 2018年 樊登. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomAlertInputView : UIView

//index 1：取消 2：确定
@property (nonatomic, copy) void(^customAlertInputViewAction)(NSString * text, CustomAlertInputView * alertView);

/**
 自定义
 
 @param title 标题
 @param inputText 内容
 @return 空
 */
- (instancetype)initWithTitle:(NSString *)title inputText:(NSString *)inputText;

- (void)refreshView;

- (void)showCustomAlertView;

@end
