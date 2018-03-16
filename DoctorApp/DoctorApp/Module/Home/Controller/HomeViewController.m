//
//  HomeViewController.m
//  DoctorApp
//
//  Created by 樊登 on 2018/3/2.
//  Copyright © 2018年 樊登. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray * listArray;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    self.listArray = @[@"无标题样式",@"有标题无内容样式",@"有标题有内容样式",@"有标题无内容样式只有确定按钮",@"有标题无内容样式只有取消按钮",@"自定义背景颜色样式"];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.listArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        [self createAlertView:nil message:self.listArray[indexPath.row] confirm:@"确定" cancal:@"取消"];
    } else if (indexPath.row == 1) {
        [self createAlertView:self.listArray[indexPath.row] message:nil confirm:@"确定" cancal:@"取消"];
    } else if (indexPath.row == 2) {
        [self createAlertView:self.listArray[indexPath.row] message:@"内容1111" confirm:@"确定" cancal:@"取消"];
    }else if (indexPath.row == 3) {
        [self createAlertView:self.listArray[indexPath.row] message:nil confirm:@"确定" cancal:nil];
    }else if (indexPath.row == 4) {
        [self createAlertView:self.listArray[indexPath.row] message:nil confirm:nil cancal:@"取消"];
    } else {
        CustomAlertView *alertView = [[CustomAlertView alloc] initWithTitle:self.listArray[indexPath.row] message:@"很实用" confirmBtn:@"确定" cancleBtn:@"取消" isTopTitle:YES];
        alertView.topColor = kThemeColor;
        alertView.topTitleColor = [UIColor whiteColor];
        alertView.confirmTitleColor = [UIColor whiteColor];
        alertView.confirmColor = [UIColor redColor];
        alertView.cancalColor = [UIColor colorWithHex:@"#eff5f7"];
        alertView.cancalTitleColor = kMainColor;
        [alertView refreshView];
        [alertView setCustomAlertViewClickAction:^(NSInteger index, CustomAlertView *alertView) {
            if (index == 1) {
                [alertView removeFromSuperview];
            } else {
                [alertView removeFromSuperview];
            }
        }];
        
        [alertView showCustomAlertView];
    }
}

- (void)createAlertView:(NSString *)title message:(NSString *)message confirm:(NSString *)confirm cancal:(NSString *)cancal {
    
    CustomAlertView *alertView = [[CustomAlertView alloc] initWithTitle:title message:message confirmBtn:confirm cancleBtn:cancal isTopTitle:NO];
    
    [alertView setCustomAlertViewClickAction:^(NSInteger index, CustomAlertView *alertView) {
        if (index == 1) {
            [alertView removeFromSuperview];
        } else {
            [alertView removeFromSuperview];
        }
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
