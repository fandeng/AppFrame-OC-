//
//  MineViewController.m
//  DoctorApp
//
//  Created by 樊登 on 2018/3/2.
//  Copyright © 2018年 樊登. All rights reserved.
//

#import "MineViewController.h"
#import "MineView.h"
#import "SettingViewController.h"
#import "CardViewController.h"
#import "MineInfoViewController.h"

@interface MineViewController ()<UINavigationControllerDelegate>

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    MineView *mineView = [[MineView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [mineView refreshView];
    WS(weakself)
    [mineView setCustomMineViewAction:^(NSInteger index) {
        [weakself clickCustomViewAction:index];
    }];
    [mineView setCustomTableViewAction:^(NSIndexPath *path, MineView *mineView) {
        [weakself clickTableViewAction:path];
    }];
    [self.view addSubview:mineView];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(nonnull UIViewController *)viewController animated:(BOOL)animated {
    
    BOOL isShowSelfPage = viewController == self ? true : false;
    
    [navigationController setNavigationBarHidden:isShowSelfPage animated:true];
}
//点击头部事件
- (void)clickCustomViewAction:(NSInteger)index {
    if (index == 1) {
        CardViewController * cardVC = [[CardViewController alloc] init];
        cardVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:cardVC animated:YES];
    } else if (index == 2) {
        SettingViewController * setVC = [[SettingViewController alloc] init];
        setVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setVC animated:YES];
    } else {
        MineInfoViewController * infoVC = [[MineInfoViewController alloc] init];
        infoVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:infoVC animated:YES];
    }
}
//点击列表cell
- (void)clickTableViewAction:(NSIndexPath *)path {
    [CommonMethod createAlertView:nil message:[NSString stringWithFormat:@"点击%ld--%ld",(long)path.section,path.row] time:1.0];
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
