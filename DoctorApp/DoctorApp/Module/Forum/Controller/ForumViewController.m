//
//  ForumViewController.m
//  DoctorApp
//
//  Created by 樊登 on 2018/3/2.
//  Copyright © 2018年 樊登. All rights reserved.
//

#import "ForumViewController.h"
#import "ForumDetailViewController.h"
#import "ForumTableViewCell.h"

@interface ForumViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray * listArray;

@end

@implementation ForumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.listArray = @[@{
                           @"userLogo":@"http://pic.qiantucdn.com/58pic/27/77/05/60h58PICRcJ_1024.jpg!/fw/780/watermark/url/L3dhdGVybWFyay12MS40LnBuZw==/align/center",
                           @"nickname":@"楚宇轩",
                           @"createTime":@"2018-03-06 16:30:30",
                           @"num":@"12",
                           @"title":@"似懂非懂防辐射的",
                           @"content":@"不知道，怎么办"
                        },
                       @{
                           @"userLogo":@"http://pic.qiantucdn.com/58pic/27/77/05/60h58PICRcJ_1024.jpg!/fw/780/watermark/url/L3dhdGVybWFyay12MS40LnBuZw==/align/center",
                           @"nickname":@"张依依",
                           @"createTime":@"2018-03-06 16:30:30",
                           @"num":@"12",
                           @"title":@"方式对双方都？",
                           @"content":@"盛世嫡妃所发生的所说的水电费是否大是大非  发送到对方水电费等方式搜索发"
                        },
                       @{
                           @"userLogo":@"http://pic.qiantucdn.com/58pic/27/75/48/08y58PICeAs_1024.jpg!/fw/780/watermark/url/L3dhdGVybWFyay12MS40LnBuZw==/align/center",
                           @"nickname":@"叶潇",
                           @"createTime":@"2018-03-06 13:30:30",
                           @"num":@"16",
                           @"title":@"敖德萨多",
                           @"content":@"盛世嫡妃所发生的所说的水电费是否大是大非  发送到对方水电费等方式搜索发盛世嫡妃所发生的所说的水电费是否大是大非  发送到对方水电费等方式搜索发"
                        },
                       @{
                           @"userLogo":@"http://pic.qiantucdn.com/58pic/18/19/68/49258PICIKQ_1024.jpg!/fw/780/watermark/url/L3dhdGVybWFyay12MS40LnBuZw==/align/center",
                           @"nickname":@"花月舞",
                           @"createTime":@"2018-03-03 16:30:30",
                           @"num":@"10",
                           @"title":@"答案是啊",
                           @"content":@"盛世嫡妃所发生的所说的水电费是否大是大非  发送到对方水电费等方式搜索发盛世嫡妃所发生的所说的水电费是否大是大非  发送到对方水电费等方式搜索发盛世嫡妃所发生的所说的水电费是否大是大非  发送到对方水电费等方式搜索发盛世嫡妃所发生的所说的水电费是否大是大非  发送到对方水电费等方式搜索发"
                        }];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.tableView registerNib:[UINib nibWithNibName:@"ForumTableViewCell" bundle:nil] forCellReuseIdentifier:@"forumCell_id"];
    self.tableView.estimatedRowHeight = UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary * dic = self.listArray[indexPath.row];
    CGFloat height = [CommonMethod compareLabelLayoutHeight:dic[@"content"] font:kSubtitleFont width:ScreenWidth-20 space:5];
    return height < 35 ? 130 : 155;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ForumTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"forumCell_id" forIndexPath:indexPath];
    NSDictionary * dic = self.listArray[indexPath.row];
    [cell refreshWithData:dic];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ForumDetailViewController * forumDetailVC = [[ForumDetailViewController alloc] init];
    forumDetailVC.hidesBottomBarWhenPushed = YES;
    NSDictionary * dic = self.listArray[indexPath.row];
    forumDetailVC.dic = dic;
    [self.navigationController pushViewController:forumDetailVC animated:YES];
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
