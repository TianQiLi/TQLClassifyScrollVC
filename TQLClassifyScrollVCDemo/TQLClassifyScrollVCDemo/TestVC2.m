//
//  TestVC2.m
//  TQLClassifyScrollVCDemo
//
//  Created by litianqi on 2019/5/14.
//  Copyright © 2019 edu24ol. All rights reserved.
//

#import "TestVC2.h"
#import "CustomTableViewCell2.h"

@interface TestVC2()<UITableViewDelegate, UITableViewDataSource>
@property (assign ,atomic) NSInteger  count;
@property (strong ,atomic) NSString * name;

@end

@implementation TestVC2

- (void)viewDidLoad{
    //tableView 配置
    [CustomTableViewCell2 registerNibInTableView:self.tableView];
    self.mjRefreshColor = [UIColor redColor];
    self.enableHeaderRefresh = YES;
    self.enableFooterRefresh = YES;

    self.pageRows = 12;
    self.pageFirst = 0;
    self.tableView.backgroundColor = [UIColor greenColor];
    self.tableView.separatorColor = [UIColor redColor];
    self.dataStatusEmptyBGColor = @"0xf4f6f9";
    self.verticalOffset = @(-30);
    self.dataStatusNoData_img = @"qa_noquestion";
    self.dataStatusNoData_text_fontSize = @(14);
}

-(void)viewWillAppear:(NSInteger)index
{
    NSLog(@"%s,count= %ld, name= %@\n",__func__,self.count,self.name);
}

-(void)viewDidDisappear:(NSInteger)index{
    
}

-(void)basicRequestData{
    //TODO: 网络请求
    self.count = self.row;
    if (self.row == 0) {
        //接口返回成功获取到了
//        self.count = self.row;
        self.name = [@(self.row) stringValue];
        [NSThread sleepForTimeInterval:1.5];
      
        self.successBlock(@[@"11",@"22",@"33"]);
    }
    else if (self.row == 1) {
        //接口返回成功获取到了
//        self.count = 2;
        self.name = @"1";
        [NSThread sleepForTimeInterval:1.5];
     
        self.successBlock(@[@"11",@"22"]);
    }else{
        //接口返回失败
        self.successBlock(@[@"1"]);
    }
    
    
}

#pragma mark -- <UITableViewDelegate, UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomTableViewCell2 * cell = [tableView dequeueReusableCellWithIdentifier:[CustomTableViewCell2 cellIdentifiter] forIndexPath:indexPath];
    cell.nameL.text = [NSString stringWithFormat:@"tab=%ld-count=%ld row=%ld",self.row,self.count,indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CustomTableViewCell2 cellHeight];
}

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
