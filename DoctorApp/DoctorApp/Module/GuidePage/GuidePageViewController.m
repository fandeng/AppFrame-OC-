//
//  GuidePageViewController.m
//  BabyLove
//
//  Created by 唐亮 on 16/1/7.
//  Copyright © 2016年 bengo. All rights reserved.
//

#import "GuidePageViewController.h"

@interface GuidePageViewController ()

@end

@implementation GuidePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createScrollView];
    
}

- (void)createScrollView {
    
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    
    for (int i = 0; i < 3; i++) {
        
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"yindao_0%d.jpg",i+1]];
        
        UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth * i, 0, ScreenWidth, ScreenHeight)];
        
        if (i == 2) {
            
            imgView.userInteractionEnabled = YES;
            
            UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth / 3-10, ScreenHeight * 7 / 8 - 40 , ScreenWidth / 3 + 20, 60)];
            
            [button setTitle:@"" forState:UIControlStateNormal];
            
            [button setTitleColor:kMainColor forState:UIControlStateNormal];

            [button addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
            
            [imgView addSubview:button];
        }
        
        imgView.image = image;
        
        [scrollView addSubview:imgView];
    }
    
    scrollView.bounces = NO;
    
    scrollView.pagingEnabled = YES;
    
    scrollView.showsHorizontalScrollIndicator = NO;
    
    scrollView.contentSize = CGSizeMake(ScreenWidth * 3, ScreenHeight);
    
    [self.view addSubview: scrollView];
}


- (void)clickAction {
    
    NSUserDefaults *userdefauls = [NSUserDefaults standardUserDefaults];
    
    [userdefauls setObject:[CommonMethod clientVersionCode] forKey:@"appVersion"];
    
    [APP_DELEGATE resetWindowRootViewController:ShowCurrentModule_Login];
    
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
