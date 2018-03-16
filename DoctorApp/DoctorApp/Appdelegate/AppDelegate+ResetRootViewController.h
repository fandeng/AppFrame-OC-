//
//  AppDelegate+ResetRootViewController.h
//  BabyLove
//
//  Created by 唐亮 on 16/01/07.
//  Copyright © 2015年 bengo. All rights reserved.
//

#import "AppDelegate.h"

typedef NS_ENUM(NSInteger, ShowCurrentModule) {
  
    ShowCurrentModule_GuidePage,          //引导页
    ShowCurrentModule_Login,              //登陆
    ShowCurrentModule_Home,               //主页

};

@interface AppDelegate (ResetRootViewController)

/**
 *  重置Window的RootViewController
 *
 *  @param type 模块
 */
- (void)resetWindowRootViewController:(ShowCurrentModule)type;

@end
