//
//  LoginViewController.m
//  GoldMuSen
//
//  Created by 樊登 on 2017/9/26.
//  Copyright © 2017年 樊登. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<UITextFieldDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UIView *phoneView;

@property (weak, nonatomic) IBOutlet UIView *pwdView;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initWithView];
    
//    self.navigationController.delegate = self;
}

- (void)initWithView {
    
    [_phoneTextField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    
    [_passwordTextField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];

    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _loginBtn.enabled = NO;
    
    _loginBtn.backgroundColor = kGrayColor;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(nonnull UIViewController *)viewController animated:(BOOL)animated {
    
    BOOL isShowSelfPage = viewController == self ? true : false;
    
    if (isShowSelfPage) {
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        
    } else {
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    
    [navigationController setNavigationBarHidden:isShowSelfPage animated:true];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (_phoneTextField.isFirstResponder) {
        
        [_phoneTextField resignFirstResponder];
    }
    
    if (_passwordTextField.isFirstResponder) {
        
        [_passwordTextField resignFirstResponder];
    }
}

- (IBAction)clickSeePasswordAction:(UIButton *)sender {
    
    _passwordTextField.secureTextEntry = !_passwordTextField.secureTextEntry;
    
    [sender setImage:[UIImage imageNamed:@"seeon"] forState:UIControlStateNormal];
    
    if (_passwordTextField.secureTextEntry) {
        
        [sender setImage:[UIImage imageNamed:@"seeoff"] forState:UIControlStateNormal];
    }
}

- (IBAction)clickLoginAction:(UIButton *)sender {
    
    if ([self isCheckPhoneAndPassword]) {
    
        [CommonMethod showProgressHUDWithTitle:@"正在登录..." inView:self.view animated:YES];

        [CommonMethod hideProgressHUDInView:self.view delegate:nil animated:YES afterDelay:0];

        [APP_DELEGATE resetWindowRootViewController:ShowCurrentModule_Home];
        
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
    
    if (textField == _passwordTextField) {
        
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

- (void)textChange {
    
    if (_phoneTextField.text.length == 11 && _passwordTextField.text.length > 0) {
        
        _loginBtn.enabled = YES;
        
        _loginBtn.backgroundColor = kThemeColor;
        
    } else {
        
        _loginBtn.enabled = NO;
        
        _loginBtn.backgroundColor = kGrayColor;
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
