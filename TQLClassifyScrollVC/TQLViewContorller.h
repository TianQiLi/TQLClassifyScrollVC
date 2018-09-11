//
//  TQLCollectionViewCell.h
//  
//
//  Created by litianqi on 2017/9/5.
//  Copyright © 2017年 edu24ol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TQLClassifyScrollVC.h"
#import "TQLCollectionViewCellBase.h"
#import "TQLCollectionViewCell+DZNEmptyDataSet.h"
#import "TQLSwitchViewTool.h"
#import "MJRefresh.h"
extern NSString * const SwitchBttonClickNotification;
extern NSString * const CellSelectedNotification;

@interface TQLViewContorller : TQLCollectionViewCellBase
/** 外部传进来的额外参数 */
@property (nonatomic, strong) NSDictionary *paraDic;
/** id */
@property (nonatomic, weak) TQLClassifyScrollVC * currentVC;

/* 所有页面的数据  */
@property (nonatomic, strong) NSMutableDictionary *dataForRowArray;
/*当前页面的数据集合*/
@property (nonatomic, copy) NSArray *arrayData;

/* 保存每个控制器(row)当前滑动到的页码*/
@property (nonatomic, strong) NSMutableDictionary *pageForIndex;
/** row - 容器CollectionCell-indexpath.row */
@property (nonatomic, assign) NSInteger row;
/** 当前页码-第几页 - 默认第0页- 当前控制器currentVC*/
@property (nonatomic, assign) NSInteger page;
/** 每页的行数 - 默认20 */
@property (nonatomic, assign) NSInteger pageRows;
/** 第一页的起止页码 - 默认0 */
@property (assign, nonatomic) NSInteger pageFirst;//默认0

/** btnArray */
@property (nonatomic, strong) NSArray *switchToolBtnArray;

/** itemArray */
@property (nonatomic, strong) NSArray *switchToolItemArray;

@property (nonatomic, strong) UIColor * mjRefreshColor;


@property (nonatomic, copy)  SuccessBlock  successBlock;
@property (nonatomic, copy)  FailureBlock  failureBlock;
@property (assign, nonatomic) BOOL enableHeaderRefresh;//默认NO
@property (assign, nonatomic) BOOL enableFooterRefresh;//默认NO


/** 1...n */
@property (nonatomic, assign,readonly) NSInteger currentSwitchBtnIndex;

- (void)cellForItem:(NSInteger)row;
- (void)willDisplayRow:(NSInteger)row;

- (void)setCurrentVC:(TQLClassifyScrollVC *)currentVC;
- (TQLSwitchViewTool *)switchViewTool;
/*need override*/
- (BOOL)ignoreSwitchBtnEvent;
//建议重写：自定义
+ (NSString *)cellIdentifiter;

#pragma mark -- 接口网络请求
- (void)basicRequestData;
- (void)loadTopData;
- (void)loadMoreData;

- (TQLRedBadgeBttton *)currentSwitchBtn;
- (NSString *)currentSwitchItem;
@end
