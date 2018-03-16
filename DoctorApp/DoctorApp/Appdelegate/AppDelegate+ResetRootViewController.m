//
//  AppDelegate+ResetRootViewController.m
//  BabyLove
//
//  Created by 唐亮 on 16/01/07.
//  Copyright © 2015年 bengo. All rights reserved.
//

#import "AppDelegate+ResetRootViewController.h"

#import "GuidePageViewController.h"

@implementation AppDelegate (ResetRootViewController)

- (void)resetWindowRootViewController:(ShowCurrentModule)type {
    
    switch (type) {

        case ShowCurrentModule_GuidePage: {
            
            GuidePageViewController *guide = [[GuidePageViewController alloc] init];
            
            self.window.rootViewController = guide;
            
            break;
        }
           
        case ShowCurrentModule_Login: {
            
            UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Login" bundle:nil];
            
            self.window.rootViewController =[storyboard instantiateInitialViewController];
            
            break;
        }

        case ShowCurrentModule_Home: {
            
            UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            self.window.rootViewController = [storyboard instantiateInitialViewController];
            
            break;
        }

        default:
            break;
    }
}

@end
