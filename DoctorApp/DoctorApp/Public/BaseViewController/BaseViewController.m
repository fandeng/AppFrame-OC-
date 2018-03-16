//
//  BaseViewController.m
//  GoldMuSen
//
//  Created by 樊登 on 2017/9/26.
//  Copyright © 2017年 樊登. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //修改导航栏背景颜色
    self.navigationController.navigationBar.barTintColor = kThemeColor;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:kNavFont(16)} forState:UIControlStateNormal];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.tabBarController.tabBar setTintColor:kThemeColor];
    
    [self.tabBarController.tabBar setBarTintColor:[UIColor whiteColor]];
}

- (void)createBackButton {
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"goback"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  style:UIBarButtonItemStylePlain target:self action:@selector(clickBackButtonAction)];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)createRightItem:(NSString *)title image:(UIImage *)image {
    
    if (title) {
        
        UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(clickRightButtonAction)];
        
        self.navigationItem.rightBarButtonItem = leftItem;
        
    } else {
        UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  style:UIBarButtonItemStylePlain target:self action:@selector(clickRightButtonAction)];
        
        self.navigationItem.rightBarButtonItem = leftItem;
    }

}

- (void)clickBackButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickRightButtonAction {
    
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
