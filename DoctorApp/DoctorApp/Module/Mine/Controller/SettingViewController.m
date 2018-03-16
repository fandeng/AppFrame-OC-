//
//  SettingViewController.m
//  DoctorApp
//
//  Created by 樊登 on 2018/3/6.
//  Copyright © 2018年 樊登. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingTableViewCell.h"
#import "ChangePwdViewController.h"

@interface SettingViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray * listArray;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self createBackButton];
    self.listArray = @[@"修改密码", @"消息推送", @"清除缓存"];;
    [self creatTabelViewFooter];
    [self.tableView registerNib:[UINib nibWithNibName:@"SettingTableViewCell" bundle:nil] forCellReuseIdentifier:@"settingCell_id"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"settingCell_id" forIndexPath:indexPath];
    double number = (unsigned long)[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
    if (indexPath.row == 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.row == 1) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell refreshWithTitle:self.listArray[indexPath.row] content:[NSString stringWithFormat:@"%.2fM",number] row:indexPath.row switchValue:YES];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        ChangePwdViewController * changeVC = [[ChangePwdViewController alloc] init];
        [self.navigationController pushViewController:changeVC animated:YES];
    } else if (indexPath.row == 1) {
        
    } else {
        CustomAlertView *alertView = [[CustomAlertView alloc] initWithTitle:nil message:@"是否清除缓存？" confirmBtn:@"确定" cancleBtn:@"取消" isTopTitle:NO];
        alertView.confirmTitleColor = [UIColor whiteColor];
        alertView.confirmColor = [UIColor redColor];
        alertView.cancalColor = [UIColor colorWithHex:@"#eff5f7"];
        alertView.cancalTitleColor = kMainColor;
        [alertView refreshView];
        WS(weakself)
        [alertView setCustomAlertViewClickAction:^(NSInteger index, CustomAlertView *alertView) {
            if (index == 2) {
                [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
                [weakself.tableView reloadData];
            }
            [alertView removeFromSuperview];
        }];
        [alertView showCustomAlertView];
    }
}

- (void)creatTabelViewFooter {
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, ScreenWidth-30, 100)];
    UIButton *btExitLogin = [[UIButton alloc] initWithFrame:CGRectMake(0, 55, ScreenWidth-30, 45)];
    btExitLogin.backgroundColor = kThemeColor;
    btExitLogin.layer.cornerRadius = 8;
    btExitLogin.clipsToBounds = YES;
    [btExitLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btExitLogin setTitle:@"退出当前账号" forState:UIControlStateNormal];
    btExitLogin.titleLabel.font = kNavFont(16);
    [btExitLogin addTarget:self action:@selector(LogoutEvent) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:btExitLogin];
    [footView borderForColor:[UIColor colorWithHex:@"#e0e0e2"] borderWidth:1.0f borderType:UIBorderSideTypeTop];
    self.tableView.tableFooterView = footView;
}

- (void)LogoutEvent {
    CustomAlertView *alertView = [[CustomAlertView alloc] initWithTitle:nil message:@"确定退出登录？" confirmBtn:@"确定" cancleBtn:@"取消" isTopTitle:NO];
    alertView.confirmTitleColor = [UIColor whiteColor];
    alertView.confirmColor = [UIColor redColor];
    alertView.cancalColor = [UIColor colorWithHex:@"#eff5f7"];
    alertView.cancalTitleColor = kMainColor;
    [alertView refreshView];
    [alertView setCustomAlertViewClickAction:^(NSInteger index, CustomAlertView *alertView) {
        if (index == 2) {
            [APP_DELEGATE resetWindowRootViewController:ShowCurrentModule_Login];
        }
        [alertView removeFromSuperview];
    }];
    [alertView showCustomAlertView];
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
