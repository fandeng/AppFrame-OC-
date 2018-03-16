//
//  BaseViewController.h
//  GoldMuSen
//
//  Created by 樊登 on 2017/9/26.
//  Copyright © 2017年 樊登. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

- (void)createBackButton;

- (void)clickBackButtonAction;

- (void)createRightItem:(NSString *)title image:(UIImage *)image;

- (void)clickRightButtonAction;

@end
