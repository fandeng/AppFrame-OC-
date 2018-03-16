//
//  MineView.h
//  DoctorApp
//
//  Created by 樊登 on 2018/3/5.
//  Copyright © 2018年 樊登. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineView : UIView

//index 点击下标
@property (nonatomic, copy) void(^customMineViewAction)(NSInteger index);

@property (nonatomic, copy) void(^customTableViewAction)(NSIndexPath * path, MineView * mineView);

- (void)refreshView;

@end
