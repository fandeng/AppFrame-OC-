//
//  MineView.m
//  DoctorApp
//
//  Created by 樊登 on 2018/3/5.
//  Copyright © 2018年 樊登. All rights reserved.
//

#import "MineView.h"
#import "MineHeaderView.h"

@interface MineView() <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, copy) NSArray * listArray;

@property (nonatomic, copy) NSArray * contentArray;

@end

@implementation MineView

//懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -20, ScreenWidth, ScreenHeight-29) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kBgColor;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _tableView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.listArray = @[@[@"个人主页",@"实名认证"],@[@"我的账户",@"我的论坛",@"我的消息",@"我的评价"],@[@"客服中心",@"设置门诊时间"],@[@"绑定支付宝",@"绑定微信"]];
        self.contentArray = @[@[@"",@"已认证"],@[@"",@"",@"",@""],@[@"",@""],@[@"未绑定",@"未绑定"]];
        [self addSubview:self.tableView];
    }
    return self;
}

- (void)refreshView {
    [self.tableView reloadData];
    MineHeaderView * headerView = [[NSBundle mainBundle] loadNibNamed:@"MineHeaderView" owner:nil options:nil].lastObject;
    headerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [headerView refreshWithHeader:@"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3835665625,849187119&fm=27&gp=0.jpg" name:@"陈医生"];
    WS(weakself)
    [headerView setClickMineHeaderViewAction:^(NSInteger type, MineHeaderView *mineView) {
        !weakself.customMineViewAction?:weakself.customMineViewAction(type);
    }];
    self.tableView.tableHeaderView = headerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.listArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.listArray[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    cell.textLabel.font = kMainFont;
    cell.textLabel.textColor = kTitleColor;
    cell.textLabel.text = self.listArray[indexPath.section][indexPath.row];
    cell.detailTextLabel.font = kSubtitleFont;
    cell.detailTextLabel.textColor = kMainColor;
    cell.detailTextLabel.textAlignment = NSTextAlignmentRight;
    cell.detailTextLabel.text = self.contentArray[indexPath.section][indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    !self.customTableViewAction?:self.customTableViewAction(indexPath, self);
}

@end
