//
//  MineHeaderView.h
//  DoctorApp
//
//  Created by 樊登 on 2018/3/5.
//  Copyright © 2018年 樊登. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

//type 1:名片 2:设置 3:个人资料
@property (nonatomic, copy) void(^clickMineHeaderViewAction)(NSInteger type, MineHeaderView * mineView);

- (void)refreshWithHeader:(NSString *)url name:(NSString *)name;

@end
