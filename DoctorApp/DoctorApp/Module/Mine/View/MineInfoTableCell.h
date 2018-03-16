//
//  MineInfoTableCell.h
//  DoctorApp
//
//  Created by 樊登 on 2018/3/8.
//  Copyright © 2018年 樊登. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineInfoTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *userLogoImgView;

- (void)refreshWithData:(NSString *)title subtitle:(NSString *)subtitle url:(NSString *)url;

@end
