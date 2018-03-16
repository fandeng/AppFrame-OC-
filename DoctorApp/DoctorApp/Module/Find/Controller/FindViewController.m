//
//  FindViewController.m
//  DoctorApp
//
//  Created by 樊登 on 2018/3/2.
//  Copyright © 2018年 樊登. All rights reserved.
//

#import "FindViewController.h"
#import "FindTableViewCell.h"
#import "CKSlideMenu.h"
#import "InformationViewController.h"
#import "SearchViewController.h"

@interface FindViewController ()<UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, copy) NSArray * listArray;
@property (nonatomic, copy) NSString* searchText;

@end

@implementation FindViewController

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
                           @"title":@"水电费水电费是否对胜多负少对方是否大幅度f's'f？"
                        },
                       @{
                           @"coverUrl":@"http://pic.qiantucdn.com/58pic/27/77/05/60h58PICRcJ_1024.jpg!/fw/780/watermark/url/L3dhdGVybWFyay12MS40LnBuZw==/align/center",
                           @"author":@"张依依",
                           @"createTime":@"2018-03-06 16:30:30",
                           @"title":@"盛世嫡妃所发生的所说的水电费是否大是大非  发送到对方水电费等方式搜索发盛世嫡妃所发生的所说的水电费是否大是大非  发送到对方水电费等方式搜索发盛世嫡妃所发生的所说的水电费是否大是大非  发送到对方水电费等方式搜索发？"
                        },
                       @{
                           @"coverUrl":@"http://pic.qiantucdn.com/58pic/27/75/48/08y58PICeAs_1024.jpg!/fw/780/watermark/url/L3dhdGVybWFyay12MS40LnBuZw==/align/center",
                           @"author":@"杨振虎",
                           @"createTime":@"2018-03-06 13:30:30",
                           @"title":@"盛世嫡妃所发生的所说的水电费是否大是大非  发送到对方水电费等方式搜索发盛世嫡妃所发生的所说的水电费是否大是大非  发送到对方水电费等方式搜索发盛世嫡妃所发生的所说的水电费是否大是大非  发送到对方水电费等方式搜索发？"
                        }];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.tableView registerNib:[UINib nibWithNibName:@"FindTableViewCell" bundle:nil] forCellReuseIdentifier:@"findCell"];
    [self createSearchBarView];
    [self createTopView];
    UITapGestureRecognizer *tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewTouchInSide)];
    tableViewGesture.numberOfTapsRequired = 1;//几个手指点击
    tableViewGesture.cancelsTouchesInView = NO;//是否取消点击处的其他action
    [self.tableView addGestureRecognizer:tableViewGesture];
}

- (void)tableViewTouchInSide {
    [self.searchBar resignFirstResponder];
}

- (void)createSearchBarView {
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - 30, 44)];
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 8, titleView.frame.size.width-40, 30)];
    _searchBar.delegate = self;
    _searchBar.layer.cornerRadius = 8;
    _searchBar.layer.masksToBounds = YES;
    [_searchBar.layer setBorderWidth:8];
    [_searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];  //设置边框为白色
    _searchBar.placeholder = @"请输入关键字";
    UITextField * searchField = [_searchBar valueForKey:@"_searchField"];
    searchField.font = kSubtitleFont;
    [searchField setValue:kSubtitleFont forKeyPath:@"_placeholderLabel.font"];
    searchField.clearButtonMode = UITextFieldViewModeNever;
    _searchBar.tintColor = [UIColor blueColor];
    [titleView addSubview:_searchBar];
    UIButton * confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_searchBar.frame)+5, 8, 50, 30)];
    [confirmBtn setTitle:@"搜索" forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = kTitleFont;
    confirmBtn.contentMode = UIViewContentModeCenter;
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(clickSearchAction) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:confirmBtn];
    [self.navigationItem.titleView sizeToFit];
    self.navigationItem.titleView = titleView;
}

- (void)createTopView {
    NSArray *titles = @[@"水电费",@"电商十大",@"颠三倒四",@"相册",@"彩信相册"];
    CKSlideMenu *slideMenu = [[CKSlideMenu alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40) titles:titles controllers:nil];
    slideMenu.showLine = NO;
    slideMenu.showIndicator = NO;
    slideMenu.isFixed = YES;
    [slideMenu setClickSlideMenuAction:^(NSInteger index) {
        NSLog(@"点击第%ld个",index);
    }];
    [self.topView addSubview:slideMenu];
}

//点击搜索
- (void)clickSearchAction {
    if ( _searchText != nil && _searchText.length > 0 ) {
        [self jumpSearchVC];
    } else {
        [CommonMethod createAlertView:nil message:@"搜索内容不能为空" time:1.0];
    }
}

//搜索协议
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    _searchText = searchBar.text;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    _searchText = searchBar.text;
    [self.searchBar resignFirstResponder];
    [self jumpSearchVC];
}

- (void)jumpSearchVC {
    SearchViewController * searchVC = [[SearchViewController alloc] init];
    searchVC.hidesBottomBarWhenPushed = YES;
    searchVC.searchString = self.searchText;
    [self.navigationController pushViewController:searchVC animated:YES];
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
