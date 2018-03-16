//
//  DepartmentViewController.m
//  DoctorApp
//
//  Created by 樊登 on 2018/3/8.
//  Copyright © 2018年 樊登. All rights reserved.
//

#import "DepartmentViewController.h"
#import "DepartmentTableCell.h"

@interface DepartmentViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *firstTableView;
@property (nonatomic, copy) NSArray *listArray;
@property (nonatomic, copy) NSArray *nextArray;

@end

@implementation DepartmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择科室";
    [self createBackButton];
    self.tableView.tag = 1000;
    self.firstTableView.tag = 1001;
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.firstTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    self.listArray = @[@"内科", @"外科", @"骨伤科", @"耳鼻咽喉科", @"中医科", @"眼科", @"儿科"];
    self.nextArray = @[@"呼吸内科", @"心血管内科", @"神经内科", @"消化内科", @"内分泌与代谢科", @"风湿免疫科", @"感染科"];
    [self.tableView registerNib:[UINib nibWithNibName:@"DepartmentTableCell" bundle:nil] forCellReuseIdentifier:@"departmentCell_id"];
    [self.firstTableView registerNib:[UINib nibWithNibName:@"DepartmentTableCell" bundle:nil] forCellReuseIdentifier:@"departmentCell_id"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 1000) {
        return self.listArray.count;
    }
    return self.nextArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DepartmentTableCell * cell = [tableView dequeueReusableCellWithIdentifier:@"departmentCell_id" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (tableView.tag == 1000) {
        cell.titleLabel.text = self.listArray[indexPath.row];
        if ((indexPath.row == self.lastPath.row && self.lastPath != nil)) {
            cell.bgView.backgroundColor = [UIColor colorWithHex:@"#C5CBD2"];
        } else {
            cell.bgView.backgroundColor = [UIColor whiteColor];
        }
    } else {
        cell.titleLabel.text = self.nextArray[indexPath.row];
        cell.bgView.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 1000) {
        NSInteger newRow = [indexPath row];
        NSInteger oldRow = (self.lastPath != nil) ? [self .lastPath row] : -1;
        if (newRow != oldRow) {
            DepartmentTableCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
            newCell.bgView.backgroundColor = [UIColor colorWithHex:@"#C5CBD2"];
            DepartmentTableCell *oldCell = [tableView cellForRowAtIndexPath:self.lastPath];
            oldCell.bgView.backgroundColor = [UIColor whiteColor];
            self .lastPath = indexPath;
        }
        self.nextArray = indexPath.row % 2 == 0 ? @[@"呼吸内科", @"心血管内科", @"神经内科", @"消化内科", @"内分泌与代谢科", @"风湿免疫科", @"感染科"] : @[@"呼吸内科", @"心血管内科", @"神经内科", @"消化内科", @"感染科"];
        [self.firstTableView reloadData];
    } else {
        NSString * departmengString = self.nextArray[indexPath.row];
        !self.clickDepartmentAction?:self.clickDepartmentAction(departmengString);
        [self.navigationController popViewControllerAnimated:YES];
    }
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
