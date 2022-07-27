//
//  TestVC.m
//  TQLClassifyScrollVCDemo
//
//  Created by litianqi on 2019/5/14.
//  Copyright © 2019 edu24ol. All rights reserved.
//

#import "TestVC.h"
#import "CustomTableViewCell.h"
#import "CustomTableViewCell2.h"
@interface TestVC()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation TestVC

- (void)viewDidLoad{
    //tableView 配置
    [CustomTableViewCell registerNibInTableView:self.tableView];
    [CustomTableViewCell2 registerNibInTableView:self.tableView];
    self.enableHeaderRefresh = YES;
    self.enableFooterRefresh = YES;
    self.pageRows = 12;
    self.pageFirst = 0;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorColor = [UIColor redColor];
    self.tq_dataStatusEmptyBGColor = @"0xf4f6f9";
    self.tq_verticalOffset = @(-30);
    self.dataStatusNoData_text_fontSize = @(14);
}

-(void)viewWillAppear:(NSInteger)index{
    NSLog(@"%s\n",__func__);
}

-(void)viewDidDisappear:(NSInteger)index{
    
}

-(void)basicRequestData{
    //TODO: 网络请求
    if (1) {
        //接口返回成功获取到了
        [NSThread sleepForTimeInterval:1.5];
//        self.successBlock(@[@"11",@"22",@"33",@"44",@"22",@"22"]);
        self.successBlock(@[]);
    }else{
        //接口返回失败
        self.failureBlock(nil);
    }
    
    
}

#pragma mark -- <UITableViewDelegate, UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.row %2 == 0) {
        CustomTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[CustomTableViewCell cellIdentifiter] forIndexPath:indexPath];
        return cell;
    }else{
        CustomTableViewCell2 * cell = [tableView dequeueReusableCellWithIdentifier:[CustomTableViewCell2 cellIdentifiter] forIndexPath:indexPath];
        return cell;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CustomTableViewCell cellHeight];
}

#pragma mark -- 基本配置
- (NSString *)reuseIdentifier{
    return [[self class]cellIdentifiter];
}

+ (NSString *)cellIdentifiter{
    return NSStringFromClass([self class]);
}

+ (void)registerNibInTableView:(UITableView*)tableView{
    [tableView registerNib:[UINib nibWithNibName:[[self class]cellIdentifiter] bundle:nil] forCellReuseIdentifier:[[self class]cellIdentifiter]];
}

@end
