//
//  InformationTableCell.h
//  DoctorApp
//
//  Created by 樊登 on 2018/3/8.
//  Copyright © 2018年 樊登. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InformationTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *coverImgView;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

- (void)refreshWithData:(NSDictionary *)dic;

@end
