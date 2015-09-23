//
//  DemoSettingController.m
//  XBSettingControllerDemo
//
//  Created by XB on 15/9/23.
//  Copyright © 2015年 XB. All rights reserved.
//

#import "DemoSettingController.h"
#import "XBConst.h"
#import "XBSettingCell.h"
#import "XBSettingItemModel.h"
#import "XBSettingSectionModel.h"
@interface DemoSettingController ()
@property (nonatomic,strong) NSArray  *sectionArray; /**< section模型数组*/

@end

@implementation DemoSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = XBMakeColorWithRGB(234, 234, 234, 1);
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self setupSections];
}

- (void)showAlert:(NSString *)title
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"点击了" message:title delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}

#pragma - mark setup
- (void)setupSections
{
    //************************************section1
    XBSettingItemModel *item1 = [[XBSettingItemModel alloc]init];
    item1.funcName = @"我的余额";
    item1.executeCode = ^{
        NSLog(@"我的余额");
        [self showAlert:@"我的余额"];
    };
    item1.detailText = @"做任务赢大奖";
    item1.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    XBSettingItemModel *item2 = [[XBSettingItemModel alloc]init];
    item2.funcName = @"修改密码";
    item2.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    XBSettingSectionModel *section1 = [[XBSettingSectionModel alloc]init];
    section1.sectionHeaderHeight = 18;
    section1.itemArray = @[item1,item2];
    
    //************************************section2
    XBSettingItemModel *item3 = [[XBSettingItemModel alloc]init];
    item3.funcName = @"推送提醒";
    item3.accessoryType = XBSettingAccessoryTypeSwitch;
    item3.switchValueChanged = ^(BOOL isOn)
    {
        NSLog(@"推送提醒开关状态===%@",isOn?@"open":@"close");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"推送提醒" message:isOn?@"open":@"close" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    };
    
    XBSettingItemModel *item4 = [[XBSettingItemModel alloc]init];
    item4.funcName = @"给我们打分";
    item4.detailImage = [UIImage imageNamed:@"icon-new"];
    item4.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    XBSettingItemModel *item5 = [[XBSettingItemModel alloc]init];
    item5.funcName = @"意见反馈";
    item5.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    XBSettingSectionModel *section2 = [[XBSettingSectionModel alloc]init];
    section2.sectionHeaderHeight = 18;
    section2.itemArray = @[item3,item4,item5];
    
    
    //************************************section3
    XBSettingItemModel *item6 = [[XBSettingItemModel alloc]init];
    item6.funcName = @"关于我们";
    item6.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    XBSettingItemModel *item7 = [[XBSettingItemModel alloc]init];
    item7.funcName = @"帮助中心";
    item7.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    XBSettingItemModel *item8 = [[XBSettingItemModel alloc]init];
    item8.funcName = @"清除缓存";
    item8.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    XBSettingSectionModel *section3 = [[XBSettingSectionModel alloc]init];
    section3.sectionHeaderHeight = 18;
    section3.itemArray = @[item6,item7,item8];
    
    self.sectionArray = @[section1,section2,section3];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    XBSettingSectionModel *sectionModel = self.sectionArray[section];
    return sectionModel.itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"setting";
    XBSettingSectionModel *sectionModel = self.sectionArray[indexPath.section];
    XBSettingItemModel *itemModel = sectionModel.itemArray[indexPath.row];
    
    XBSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[XBSettingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.item = itemModel;
    return cell;
}

#pragma - mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    XBSettingSectionModel *sectionModel = self.sectionArray[section];
    return sectionModel.sectionHeaderHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XBSettingSectionModel *sectionModel = self.sectionArray[indexPath.section];
    XBSettingItemModel *itemModel = sectionModel.itemArray[indexPath.row];
    if (itemModel.executeCode) {
        itemModel.executeCode();
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    XBSettingSectionModel *sectionModel = [self.sectionArray firstObject];
    CGFloat sectionHeaderHeight = sectionModel.sectionHeaderHeight;
    
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

@end
