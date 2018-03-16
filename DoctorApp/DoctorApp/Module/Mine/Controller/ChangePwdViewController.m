//
//  ChangePwdViewController.m
//  DoctorApp
//
//  Created by 樊登 on 2017/11/21.
//  Copyright © 2017年 樊登. All rights reserved.
//

#import "ChangePwdViewController.h"

@interface ChangePwdViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;

@property (weak, nonatomic) IBOutlet UITextField *confirmTextField;

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;


@end

@implementation ChangePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改密码";
    [self createBackButton];
    [self initWithView];
}

- (void)initWithView {
    
    [self textField:self.phoneTextField];
    [self textField:self.pwdTextField];
    [self textField:self.confirmTextField];
    [_phoneTextField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [_pwdTextField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [_confirmTextField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _confirmBtn.enabled = NO;
    _confirmBtn.backgroundColor = kGrayColor;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidChanged:) name:UIKeyboardDidChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillDisAppear:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)textField:(UITextField *)textField {
    textField.font = kMainFont;
    textField.textColor = kTitleColor;
}

#pragma mark - NSNotificationAction
- (void)keyBoardDidAppear:(NSNotification *)noti {
    //改变self.view的bounds 需要获取键盘高度
    if (_pwdTextField.isFirstResponder || _confirmTextField.isFirstResponder) {
        CGRect bounds = self.view.bounds;
        bounds.origin.y = [self offsetHeight:[self keyboardHeightFromNoti:noti]] + bounds.origin.y;
        self.view.bounds = bounds;
    } else {
        CGRect bounds = self.view.bounds;
        bounds.origin.y = 0;
        self.view.bounds = bounds;
    }
}

- (void)keyBoardDidChanged:(NSNotification *)noti {
    if (_pwdTextField.isFirstResponder || _confirmTextField.isFirstResponder ) {
        CGRect bounds = self.view.bounds;
        bounds.origin.y =  [self offsetHeight:[self keyboardHeightFromNoti:noti]] + bounds.origin.y;
        self.view.bounds = bounds;
    } else {
        CGRect bounds = self.view.bounds;
        bounds.origin.y = 0;
        self.view.bounds = bounds;
    }
}

- (void)keyBoardWillDisAppear:(NSNotification *)noti {
    
    CGRect bounds = self.view.bounds;
    
    bounds.origin.y = 0;
    
    self.view.bounds = bounds;
}

- (CGFloat)keyboardHeightFromNoti:(NSNotification *)noti {
    
    NSDictionary *info = [noti userInfo];
    
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    
    CGSize keyboardSize = [value CGRectValue].size;
    
    return keyboardSize.height;
}

- (CGFloat)offsetHeight:(CGFloat)keyboardHeight {
    
    CGRect window = [UIScreen mainScreen].bounds;
    
    CGRect textfield = [_confirmBtn convertRect:CGRectMake(0, 0, _confirmBtn.frame.size.width, _confirmBtn.frame.size.height) toView:nil];
    
    return MAX(0, keyboardHeight + textfield.size.height + textfield.origin.y +  - window.size.height);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (_phoneTextField.isFirstResponder) {
        
        [_phoneTextField resignFirstResponder];
    }
    if (_pwdTextField.isFirstResponder) {
        
        [_pwdTextField resignFirstResponder];
    }
    
    if (_confirmTextField.isFirstResponder) {
        
        [_confirmTextField resignFirstResponder];
    }
}

- (IBAction)clickConfirmAction:(UIButton *)sender {
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([string isEqualToString:@" "]) {
        
        [CommonMethod createAlertView:nil message:@"不能输入空格" time:1.0];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

- (BOOL)isCheckPhoneAndPassword {
    
    if (_phoneTextField.text.length == 0) {
        
        [CommonMethod createAlertView:nil message:@"请输入原密码" time:1.0];
        
        return NO;
    }

    if (_pwdTextField.text.length == 0) {
        
        [CommonMethod createAlertView:nil message:@"请输入新密码" time:1.0];
        
        return NO;
    }
    
    NSRange range = [_pwdTextField.text rangeOfString:@" "];
    
    if (range.location != NSNotFound) {
        
        [CommonMethod createAlertView:nil message:@"密码不能包含空格" time:1.0];
        
        return NO;
    }
    
    if (![_pwdTextField.text isEqualToString:_confirmTextField.text]) {
        
        [CommonMethod createAlertView:nil message:@"两次密码不一致" time:1.0];
        
        return NO;
    }
    
    return YES;
}

- (void)textChange {
    
    if (_phoneTextField.text.length > 0 && _pwdTextField.text.length > 0 && _confirmTextField.text.length > 0) {
        
        _confirmBtn.enabled = YES;
        
        _confirmBtn.backgroundColor = kThemeColor;
        
    } else {
        
        _confirmBtn.enabled = NO;
        
        _confirmBtn.backgroundColor = kGrayColor;
    }
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
