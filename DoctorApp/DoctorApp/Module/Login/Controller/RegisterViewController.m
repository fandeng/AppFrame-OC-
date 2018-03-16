//
//  RegisterViewController.m
//  GoldMuSen
//
//  Created by 樊登 on 2017/9/26.
//  Copyright © 2017年 樊登. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *phoneView;

@property (weak, nonatomic) IBOutlet UIView *smsView;

@property (weak, nonatomic) IBOutlet UIButton *smsBtn;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (weak, nonatomic) IBOutlet UITextField *smsTextField;

@property (weak, nonatomic) IBOutlet UIView *pwdView;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@property (nonatomic, strong) NSTimer     *timer;           // 定时器

@property (nonatomic, assign) NSInteger count;

@end

@implementation RegisterViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.subviews.firstObject.alpha = 1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createBackButton];
   
    [self initWithView];
}

- (void)initWithView {
    
    [_phoneTextField addTarget:self action:@selector(phoneTextChange) forControlEvents:UIControlEventEditingChanged];
    
    [_smsTextField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    
    [_passwordTextField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    
    [_registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _registerBtn.enabled = NO;
    
    _smsBtn.enabled = NO;
    
    _registerBtn.backgroundColor = kGrayColor;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidAppear:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidChanged:) name:UIKeyboardDidChangeFrameNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillDisAppear:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)viewWithStyle:(UIView *)view {
    
    view.layer.borderColor = [kCaptionColor CGColor];
    
    view.layer.borderWidth = 0.5;
}

#pragma mark - NSNotificationAction
- (void)keyBoardDidAppear:(NSNotification *)noti {
    
    //改变self.view的bounds 需要获取键盘高度
    if (_passwordTextField.isFirstResponder) {
        
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
    
    if (_passwordTextField.isFirstResponder) {
        
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
    
    CGRect textfield = [_registerBtn convertRect:CGRectMake(0, 0, _registerBtn.frame.size.width, _registerBtn.frame.size.height) toView:nil];
    
    return MAX(0, keyboardHeight + textfield.size.height + textfield.origin.y +  - window.size.height);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (_phoneTextField.isFirstResponder) {
        
        [_phoneTextField resignFirstResponder];
    }
    
    if (_smsTextField.isFirstResponder) {
        
        [_smsTextField resignFirstResponder];
    }
    
    if (_passwordTextField.isFirstResponder) {
        
        [_passwordTextField resignFirstResponder];
    }
}

- (IBAction)clickSendSmsAction:(UIButton *)sender {
    
    if (_phoneTextField.text.length == 11) {

        [CommonMethod showProgressHUDWithTitle:@"正在获取验证码..." inView:self.view animated:YES];

        [self startPassWordTime];
            
        [CommonMethod hideProgressHUDInView:self.view delegate:nil animated:YES afterDelay:0];
    }
}

#pragma mark - 计时器发送短信验证码
- (void)startPassWordTime
{
    [_smsBtn setEnabled:NO];
    
    self.count = 60;
    
    [_smsBtn setBackgroundColor:kGrayColor];
    
    [_smsBtn setTitle:[NSString stringWithFormat:@"%ld秒后重发", (long)_count] forState:UIControlStateDisabled];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(passwordTimerBegin) userInfo:nil repeats:YES];
}

#pragma -mark Nstimer_Method
- (void)passwordTimerBegin {
    
    --_count;
    
    if (_count >= 0) {
        
        NSString *titleString = [NSString stringWithFormat:@"%ld秒后重发", (long)_count];
        
        [_smsBtn setTitle:titleString forState:UIControlStateDisabled];
        
        [_smsBtn setBackgroundColor:kGrayColor];
        
    } else {
        
        if (_phoneTextField.text.length == 11) {
            
            [_smsBtn setBackgroundColor:kThemeColor];
            
            [_smsBtn setEnabled:YES];
        }
        [_timer invalidate];
    }
}

- (IBAction)clickSeePwdAction:(UIButton *)sender {
    
    _passwordTextField.secureTextEntry = !_passwordTextField.secureTextEntry;
    
    [sender setImage:[UIImage imageNamed:@"seeon"] forState:UIControlStateNormal];
    
    if (_passwordTextField.secureTextEntry) {
        
        [sender setImage:[UIImage imageNamed:@"seeoff"] forState:UIControlStateNormal];
    }

}

- (IBAction)clickRegisterAction:(id)sender {
    
    if ([self isCheckPhoneAndPassword]) {

        [CommonMethod showProgressHUDWithTitle:@"正在注册..." inView:self.view animated:YES];

        [CommonMethod hideProgressHUDInView:self.view delegate:nil animated:YES afterDelay:0];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//代理
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([string isEqualToString:@" "]) {
        
        [CommonMethod createAlertView:nil message:@"不能输入空格" time:1.0];
    }
    
    if (textField == _phoneTextField) {
        
        return [CommonMethod limitTextFieldWithWords:textField range:range text:string count:11];
    }
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField != _phoneTextField) {
        
        if (_phoneTextField.text.length == 0) {
            
            [CommonMethod createAlertView:nil message:@"请输入手机号码" time:1.0];
            
            return NO;
        }
        
        if (![CommonMethod isMobileNumber:_phoneTextField.text]) {
            
            [CommonMethod createAlertView:nil message:@"请输入正确的手机号码" time:1.0];
            
            return NO;
        }
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

- (BOOL)isCheckPhoneAndPassword {
    
    if (_phoneTextField.text.length == 0) {
        
        [CommonMethod createAlertView:nil message:@"请输入手机号码" time:1.0];
        
        return NO;
    }
    
    if (![CommonMethod isMobileNumber:_phoneTextField.text]) {
        
        [CommonMethod createAlertView:nil message:@"请输入正确的手机号码" time:1.0];
        
        return NO;
    }
    
    if (_smsTextField.text.length == 0) {
        
        [CommonMethod createAlertView:nil message:@"请输入验证码" time:1.0];
        
        return NO;
    }
    
    if (_passwordTextField.text.length == 0) {
        
        [CommonMethod createAlertView:nil message:@"请输入密码" time:1.0];
        
        return NO;
    }
    
    NSRange range = [_passwordTextField.text rangeOfString:@" "];
    
    if (range.location != NSNotFound) {
        
        [CommonMethod createAlertView:nil message:@"密码不能包含空格" time:1.0];
        
        return NO;
    }
    
    return YES;
}

- (void)phoneTextChange {
    
    if (_phoneTextField.text.length == 11 && _count == 0 ) {
        
        _smsBtn.enabled = YES;
        
        _smsBtn.backgroundColor = kThemeColor;
        
    } else {
        
        _smsBtn.enabled = NO;
        
        _smsBtn.backgroundColor = kGrayColor;
    }
}

- (void)textChange {
    
    if (_phoneTextField.text.length == 11 && _passwordTextField.text.length > 0 && _smsTextField.text.length > 0) {
        
        _registerBtn.enabled = YES;
        
        _registerBtn.backgroundColor = kThemeColor;
        
    } else {
        
        _registerBtn.enabled = NO;
        
        _registerBtn.backgroundColor = kGrayColor;
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
