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
                           @"title":@"乙型流感的治疗方法",
                           @"content":@"不知道，怎么办"
                        },
                       @{
                           @"userLogo":@"http://pic.qiantucdn.com/58pic/27/77/05/60h58PICRcJ_1024.jpg!/fw/780/watermark/url/L3dhdGVybWFyay12MS40LnBuZw==/align/center",
                           @"nickname":@"张依依",
                           @"createTime":@"2018-03-06 16:30:30",
                           @"num":@"12",
                           @"title":@"拉肚子怎么办？",
                           @"content":@"我经常拉肚子，吃什么拉什么，平时只敢喝粥，请问各位大神和医生，这是什么情况？"
                        },
                       @{
                           @"userLogo":@"http://pic.qiantucdn.com/58pic/27/75/48/08y58PICeAs_1024.jpg!/fw/780/watermark/url/L3dhdGVybWFyay12MS40LnBuZw==/align/center",
                           @"nickname":@"叶潇",
                           @"createTime":@"2018-03-06 13:30:30",
                           @"num":@"16",
                           @"title":@"咳嗽不止怎么办",
                           @"content":@"最近不知道怎么回事,没感冒就一直咳嗽,而且咳嗽的厉害点会出现恶心干呕的现象,特别是晚上的时候,比较严重,咳嗽多了会偶尔感觉到肺部肿胀或者是疼痛的"
                        },
                       @{
                           @"userLogo":@"http://pic.qiantucdn.com/58pic/18/19/68/49258PICIKQ_1024.jpg!/fw/780/watermark/url/L3dhdGVybWFyay12MS40LnBuZw==/align/center",
                           @"nickname":@"花月舞",
                           @"createTime":@"2018-03-03 16:30:30",
                           @"num":@"10",
                           @"title":@"头痛怎么办",
                           @"content":@"头痛health 经常头痛是怎么回事 在我们周围经常有人喊头痛 ,并为经常发作而苦恼 ,甚至怀疑自己是不是患了颅内肿瘤。其实 ,临床医生告诉我们 ,头痛越是经常发作"
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
