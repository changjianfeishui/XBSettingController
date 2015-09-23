//
//  DemoMeController.m
//  XBSettingControllerDemo
//
//  Created by XB on 15/9/23.
//  Copyright © 2015年 XB. All rights reserved.
//

#import "DemoMeController.h"
#import "XBMeHeaderView.h"
#import "XBConst.h"
#import "XBSettingCell.h"
#import "XBSettingItemModel.h"
#import "XBSettingSectionModel.h"
#import "DemoSettingController.h"
@interface DemoMeController ()
@property (nonatomic,strong) XBMeHeaderView *header;


@property (nonatomic,strong) NSArray  *sectionArray; /**< section模型数组*/
@end

@implementation DemoMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = XBMakeColorWithRGB(234, 234, 234, 1);
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self setupSections];
    
    XBMeHeaderView *header = [[[NSBundle mainBundle]loadNibNamed:@"XBMeHeaderView" owner:nil options:nil] firstObject];
    self.header = header;
    self.tableView.tableHeaderView = header;
}

- (void)setupSections
{
    
    //************************************section1
    XBSettingItemModel *item1 = [[XBSettingItemModel alloc]init];
    item1.funcName = @"我的任务1";
    item1.executeCode = ^{
        NSLog(@"我的任务1");
    };
    item1.img = [UIImage imageNamed:@"icon-list01"];
    item1.detailText = @"做任务赢大奖";
    item1.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    
    XBSettingItemModel *item2 = [[XBSettingItemModel alloc]init];
    item2.funcName = @"我的任务2";
    item2.img = [UIImage imageNamed:@"icon-list01"];
    item2.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    XBSettingItemModel *item3 = [[XBSettingItemModel alloc]init];
    item3.funcName = @"我的任务3";
    item3.img = [UIImage imageNamed:@"icon-list01"];
    item3.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    XBSettingItemModel *item4 = [[XBSettingItemModel alloc]init];
    item4.funcName = @"我的任务4";
    item4.img = [UIImage imageNamed:@"icon-list01"];
    item4.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    XBSettingSectionModel *section1 = [[XBSettingSectionModel alloc]init];
    section1.sectionHeaderHeight = 18;
    section1.itemArray = @[item1,item2,item3,item4];
    
    XBSettingItemModel *item5 = [[XBSettingItemModel alloc]init];
    item5.funcName = @"充值中心";
    item5.img = [UIImage imageNamed:@"icon-list01"];
    item5.executeCode = ^{
        NSLog(@"充值中心");
    };
    item5.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    XBSettingItemModel *item6 = [[XBSettingItemModel alloc]init];
    item6.funcName = @"设置";
    item6.img = [UIImage imageNamed:@"icon-list01"];
    item6.executeCode = ^{
        
    };
    item6.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    XBSettingSectionModel *section2 = [[XBSettingSectionModel alloc]init];
    section2.sectionHeaderHeight = 18;
    section2.itemArray = @[item5,item6];
    
    self.sectionArray = @[section1,section2];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    XBSettingSectionModel *sectionModel = self.sectionArray[section];
    return sectionModel.itemArray.count;}

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

#pragma mark - Table view delegate
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
//uitableview处理section的不悬浮，禁止section停留的方法，主要是这段代码
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
