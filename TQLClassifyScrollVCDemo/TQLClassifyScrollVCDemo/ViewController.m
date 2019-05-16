//
//  ViewController.m
//  TQLClassifyScrollVCDemo
//
//  Created by litianqi on 2019/5/14.
//  Copyright © 2019 edu24ol. All rights reserved.
//

#import "ViewController.h"
#import <TQLClassifyScrollVC_Header.h>
#import "TestVC.h"
#import "TestVC2.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 200, 100, 40);
    [btn setTitle:@"分类控制器" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}


- (void)clickEvent:(id)sender{
    NSInteger height = self.view.frame.size.height;
    TQLClassifyScrollVC * recordCouseVC = [[TQLClassifyScrollVC alloc] initWithSwitchItemArray:@[@"目录",@"答疑",@"评价"] withClassArray:@[NSStringFromClass([TestVC class]),NSStringFromClass([TestVC2 class])] withIdentifiter:@[[TestVC cellIdentifiter],[TestVC2 cellIdentifiter]] withRect:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, height)];
    
    [recordCouseVC configViewBgColor:[UIColor whiteColor] collectionBGColor:[UIColor whiteColor] swithBtnViewBGColor:nil];
    recordCouseVC.switchViewStyle = [[TQLSwitchViewStyleModel alloc] initSwitchButtonStyle:[UIColor blackColor] selectedColor:[UIColor blueColor] flagColor:[UIColor blueColor] titleNormalBtnFont:[UIFont systemFontOfSize:15] selectedNormalBtnFont:[UIFont systemFontOfSize:19] flagViewWidth:CGSizeMake(12, 2) bottomLineColor:[UIColor blueColor] bottonLineHidden:NO switchViewRect:CGRectMake(0, 0, 0, 48)];
    [recordCouseVC setSwitchButtonBottomMargin:0];
    [recordCouseVC setMJRefreshBgColor:[UIColor whiteColor]];
    recordCouseVC.title = @"课节列表";
    recordCouseVC.enableScollForSwitchClick = YES;
    recordCouseVC.justTwoScrollForSwitchClick = YES;
    
    [recordCouseVC setMJRefreshBgColor:[UIColor whiteColor]];
    
    
    [self.navigationController pushViewController:recordCouseVC animated:YES];
    
}

@end
