//
//  DepartmentViewController.h
//  DoctorApp
//
//  Created by 樊登 on 2018/3/8.
//  Copyright © 2018年 樊登. All rights reserved.
//

#import "BaseViewController.h"

@interface DepartmentViewController : BaseViewController

@property (nonatomic, copy) void(^clickDepartmentAction)(NSString * text);

@property(nonatomic, strong) NSIndexPath *lastPath;

@end
