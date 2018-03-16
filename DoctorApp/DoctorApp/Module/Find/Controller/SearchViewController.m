//
//  SearchViewController.m
//  DoctorApp
//
//  Created by 樊登 on 2018/3/8.
//  Copyright © 2018年 樊登. All rights reserved.
//

#import "SearchViewController.h"
#import "FindTableViewCell.h"
#import "InformationViewController.h"
@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, copy) NSArray * listArray;

@end

@implementation SearchViewController

-(void)viewWillDisappear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.searchBar resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.listArray = @[@{
                           @"coverUrl":@"http://pic.qiantucdn.com/58pic/18/19/68/49258PICIKQ_1024.jpg!/fw/780/watermark/url/L3dhdGVybWFyay12MS40LnBuZw==/align/center",
                           @"author":@"韩剑宇",
                           @"createTime":@"2018-03-03 16:30:30",
                           @"title":@"盛世嫡妃所发生的所说的水电费是否大是大非  发送到对方水电费等方式搜索发"
                           },
                       @{
                           @"coverUrl":@"http://pic.qiantucdn.com/58pic/27/77/05/60h58PICRcJ_1024.jpg!/fw/780/watermark/url/L3dhdGVybWFyay12MS40LnBuZw==/align/center",
                           @"author":@"张依依",
                           @"createTime":@"2018-03-06 16:30:30",
                           @"title":@"盛世嫡妃所发生的所说的水电费是否大是大非  发送到对方水电费等方式搜索发盛世嫡妃所发生的所说的水电费是否大是大非  发送到对方水电费等方式搜索发"
                           },
                       @{
                           @"coverUrl":@"http://pic.qiantucdn.com/58pic/27/75/48/08y58PICeAs_1024.jpg!/fw/780/watermark/url/L3dhdGVybWFyay12MS40LnBuZw==/align/center",
                           @"author":@"杨振虎",
                           @"createTime":@"2018-03-06 13:30:30",
                           @"title":@"盛世嫡妃所发生的所说的水电费是否大是大非  发送到对方水电费等方式搜索发盛世嫡妃所发生的所说的水电费是否大是大非  发送到对方水电费等方式搜索发盛世嫡妃所发生的所说的水电费是否大是大非  发送到对方水电费等方式搜索发"
                           }];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.tableView registerNib:[UINib nibWithNibName:@"FindTableViewCell" bundle:nil] forCellReuseIdentifier:@"findCell"];
    [self createSearchBarView];
    UITapGestureRecognizer *tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewTouchInSide)];
    tableViewGesture.numberOfTapsRequired = 1;//几个手指点击
    tableViewGesture.cancelsTouchesInView = NO;//是否取消点击处的其他action
    [self.tableView addGestureRecognizer:tableViewGesture];
}

- (void)tableViewTouchInSide {
    [self.searchBar resignFirstResponder];
}

- (void)createSearchBarView {
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - 50, 44)];
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(10, 4, titleView.frame.size.width-45, 36)];
    _searchBar.delegate = self;
    _searchBar.layer.cornerRadius = 8;
    _searchBar.layer.masksToBounds = YES;
    [_searchBar.layer setBorderWidth:8];
    [_searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];  //设置边框为白色
    _searchBar.placeholder = @"请输入关键字";
    _searchBar.text = self.searchString;
    UITextField * searchField = [_searchBar valueForKey:@"_searchField"];
    searchField.font = kSubtitleFont;
    [searchField setValue:kSubtitleFont forKeyPath:@"_placeholderLabel.font"];
    searchField.clearButtonMode = UITextFieldViewModeNever;
    _searchBar.tintColor = [UIColor blueColor];
    [titleView addSubview:_searchBar];
    UIButton * confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_searchBar.frame)+5, 4, 50, 36)];
    [confirmBtn setTitle:@"搜索" forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = kTitleFont;
    confirmBtn.contentMode = UIViewContentModeCenter;
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(clickSearchAction) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:confirmBtn];
    [self.navigationItem.titleView sizeToFit];
    self.navigationItem.titleView = titleView;
}

//点击搜索
- (void)clickSearchAction {
    if ( _searchString != nil && _searchString.length > 0 ) {
        
    } else {
        [CommonMethod createAlertView:nil message:@"搜索内容不能为空" time:1.0];
    }
}

//搜索协议
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    _searchString = searchBar.text;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    _searchString = searchBar.text;
    [self.searchBar resignFirstResponder];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FindTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"findCell" forIndexPath:indexPath];
    [cell refreshWithData:self.listArray[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.searchBar resignFirstResponder];
    InformationViewController * informationVC = [[InformationViewController alloc] init];
    informationVC.hidesBottomBarWhenPushed = YES;
    informationVC.dic = self.listArray[indexPath.row];
    [self.navigationController pushViewController:informationVC animated:YES];
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
