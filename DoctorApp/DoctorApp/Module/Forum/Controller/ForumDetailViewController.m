//
//  ForumDetailViewController.m
//  DoctorApp
//
//  Created by 樊登 on 2018/3/7.
//  Copyright © 2018年 樊登. All rights reserved.
//

#import "ForumDetailViewController.h"
#import "ForumTableViewCell.h"
#import "ForumDetailCell.h"
#import "XHInputView.h"

@interface ForumDetailViewController ()<UITableViewDelegate,UITableViewDataSource,XHInputViewDelagete>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *reviewTextField;
@property (weak, nonatomic) IBOutlet UIButton *reviewBtn;
@property (weak, nonatomic) IBOutlet UIView *reviewView;
@property (nonatomic, copy) NSMutableArray * listArray;
@property (nonatomic, strong) XHInputView *inputViewStyleDefault;

@end

@implementation ForumDetailViewController

- (NSMutableArray *)listArray {
    if (_listArray == nil) {
        _listArray = [[NSMutableArray alloc] init];
    }
    return _listArray;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"回帖";
    [self createBackButton];
    [self.listArray addObject:@[self.dic]];
    [self.listArray addObject:@[@{
                                    @"userLogo":@"http://pic.qiantucdn.com/58pic/27/77/05/60h58PICRcJ_1024.jpg!/fw/780/watermark/url/L3dhdGVybWFyay12MS40LnBuZw==/align/center",
                                    @"nickname":@"李想想",
                                    @"createTime":@"2018-03-06 16:30:30",
                                    @"content":@"不知道"
                                    },
                                @{
                                    @"userLogo":@"http://pic.qiantucdn.com/58pic/27/75/48/08y58PICeAs_1024.jpg!/fw/780/watermark/url/L3dhdGVybWFyay12MS40LnBuZw==/align/center",
                                    @"nickname":@"赵小毛",
                                    @"createTime":@"2018-03-06 13:30:30",
                                    @"content":@"大声道撒奥多 "
                                    },
                                @{
                                    @"userLogo":@"http://pic.qiantucdn.com/58pic/18/19/68/49258PICIKQ_1024.jpg!/fw/780/watermark/url/L3dhdGVybWFyay12MS40LnBuZw==/align/center",
                                    @"nickname":@"白愁飞",
                                    @"createTime":@"2018-03-03 16:30:30",
                                    @"content":@"阿萨斯啊啊房地产彩信相册新圩村"
                                    }]];
    
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.tableView registerNib:[UINib nibWithNibName:@"ForumTableViewCell" bundle:nil] forCellReuseIdentifier:@"forumCell_id"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ForumDetailCell" bundle:nil] forCellReuseIdentifier:@"forumDetailCell_id"];
    self.reviewTextField.text = @"";
    self.inputViewStyleDefault = [self inputViewWithStyle:InputViewStyleDefault];
    self.inputViewStyleDefault.delegate = self;
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self.inputViewStyleDefault];
    WS(weakSelf)
    self.inputViewStyleDefault.sendBlcok = ^(NSString *text) {
        [weakSelf.inputViewStyleDefault hide];
        weakSelf.reviewTextField.text = @"";
    };
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   return self.listArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.listArray[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary * dic = self.listArray[indexPath.section][indexPath.row];
    if (indexPath.section == 0) {
        CGFloat height = [CommonMethod compareLabelLayoutHeight:dic[@"content"] font:kMainFont width:ScreenWidth-20 space:5];
        return height <= 25 ? 130 : height+115;
    }
    CGFloat height = [CommonMethod compareLabelLayoutHeight:dic[@"content"] font:kSubtitleFont width:ScreenWidth-80 space:5];
    return height + 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 0 : 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    sectionView.backgroundColor = kBgColor;
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, ScreenWidth, 40)];
    bgView.backgroundColor = [UIColor whiteColor];
    UILabel * sectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, ScreenWidth-20, 20)];
    sectionLabel.font = kTitleFont;
    sectionLabel.textColor = kTitleColor;
    sectionLabel.text = [NSString stringWithFormat:@"评论(%@)",self.dic[@"num"]];
    [bgView addSubview:sectionLabel];
    [sectionView addSubview:bgView];
    return sectionView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ForumTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"forumCell_id" forIndexPath:indexPath];
        NSDictionary * dic = self.listArray[indexPath.section][indexPath.row];
        [cell refreshWithData:dic];
        cell.contentLabel.numberOfLines = 0;
        cell.iconImgView.hidden = YES;
        cell.numLabel.hidden = YES;
        return cell;
    }
    ForumDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"forumDetailCell_id" forIndexPath:indexPath];
    NSDictionary * dic = self.listArray[indexPath.section][indexPath.row];
    [cell refreshWithData:dic];
    return cell;
}

- (IBAction)clickReviewAction:(id)sender {
    if (self.reviewTextField.text.length == 0) {
        [CommonMethod createAlertView:nil message:@"评论不能为空" time:1.0];
        return;
    }
}

- (IBAction)clickReviewInputAction:(id)sender {
    [self.inputViewStyleDefault showInput:self.reviewTextField.text];
}

- (void)xhInputViewWillHide:(XHInputView *)inputView text:(NSString *)text {
    self.reviewTextField.text = text;
}

- (XHInputView *)inputViewWithStyle:(InputViewStyle)style{
    XHInputView *inputView = [[XHInputView alloc] initWithStyle:style];
    inputView.maxCount = 200;
    inputView.sendButtonTitle = @"评论";
    inputView.sendButtonFont = kTitleFont;
    inputView.textViewBackgroundColor = [UIColor groupTableViewBackgroundColor];
    inputView.placeholder = @"请输入你的评论";
    return inputView;
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
