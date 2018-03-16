//
//  MineInfoViewController.m
//  DoctorApp
//
//  Created by 樊登 on 2018/3/8.
//  Copyright © 2018年 樊登. All rights reserved.
//

#import "MineInfoViewController.h"
#import "MineInfoTableCell.h"
#import "CustomAlertInputView.h"
#import "DepartmentViewController.h"

@interface MineInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, copy) NSArray * listArray;

@property (nonatomic, copy) NSArray * contentArray;


@end

@implementation MineInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人资料";
    [self createBackButton];
    self.listArray = @[@"头像",@"姓名",@"性别",@"科室",@"职称",@"专长",@"执业医院",@"详细地址"];
    self.contentArray = @[@"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3835665625,849187119&fm=27&gp=0.jpg",@"陈医生",@"男",@"儿科",@"副主任医师",@"儿科急救和儿科疑难杂症",@"中山大学附属第三医院",@"中山大学教师附属楼"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MineInfoTableCell" bundle:nil] forCellReuseIdentifier:@"mineInfoCell_id"];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row==0 ? 60 : 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineInfoTableCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mineInfoCell_id" forIndexPath:indexPath];
    NSString * url = indexPath.row == 0 ? self.contentArray[indexPath.row] : nil;
    [cell refreshWithData:self.listArray[indexPath.row] subtitle:self.contentArray[indexPath.row] url:url];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MineInfoTableCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.row == 0) {
//        WS(weakSelf)
        [self showCanEdit:NO photo:^(UIImage *photo) {
            cell.userLogoImgView.image = photo;
        }];
    } else if (indexPath.row == 2) {
        [self changeSexActionAtIndexPath:indexPath];
    } else if (indexPath.row == 3) {
        DepartmentViewController * departmentVC = [[DepartmentViewController alloc] init];
        [departmentVC setClickDepartmentAction:^(NSString *text) {
            cell.subtitleLabel.text = text;
        }];
        [self.navigationController pushViewController:departmentVC animated:YES];
    } else {
        [self createAlertView:self.listArray[indexPath.row] inputText:self.contentArray[indexPath.row] indexPath:indexPath];
    }
}

- (void)changeSexActionAtIndexPath:(NSIndexPath *)indexPath {
    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"性别" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    MineInfoTableCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
    UIAlertAction * maleAction = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        cell.subtitleLabel.text = @"男";
    }];
    UIAlertAction * femaleAction = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        cell.subtitleLabel.text = @"女";
    }];
    UIAlertAction * cancalAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertView addAction:maleAction];
    [alertView addAction:femaleAction];
    [alertView addAction:cancalAction];
    [self presentViewController:alertView animated:YES completion:nil];
}

- (void)createAlertView:(NSString *)title inputText:(NSString *)inputText indexPath:(NSIndexPath *)indexPath {
    MineInfoTableCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
    CustomAlertInputView *alertView = [[CustomAlertInputView alloc] initWithTitle:title inputText:inputText];
    [alertView setCustomAlertInputViewAction:^(NSString *text, CustomAlertInputView *alertView) {
        cell.subtitleLabel.text = text;
        [alertView removeFromSuperview];
    }];
    [alertView refreshView];
    [alertView showCustomAlertView];
}

- (void)uploadImage:(UIImage *)image indexPath:(NSIndexPath *)indexPath {
    
    NSMutableDictionary *publicDic = [NSMutableDictionary dictionary];
    
    [publicDic setValue:@"ios" forKey:@"appKey"];
    
    [publicDic setValue:[CommonMethod dicSort:publicDic] forKey:@"sign"];
    
    NSURLSessionUploadTask *uploadTask =  [CommonMethod uploadTaskWithImage:image dic:publicDic completion:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        NSDictionary * dic = (NSDictionary *)responseObject;
        
        if (![dic[@"datas"] isMemberOfClass:[NSNull class]] && error == nil) {
            
//            NSDictionary *data = dic[@"datas"];
            
//            [self updateUserInfoWithName:@"avatarImage" value:data[@"filePath"] baseUrl:data[@"baseUrl"] cell:cell];
            
        }
    }];
    
    [uploadTask resume];
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
