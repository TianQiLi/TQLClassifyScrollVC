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

extern NSString * const SwitchBttonClickNotification;
extern NSString * const CellSelectedNotification;

@interface TQLViewContorller : TQLCollectionViewCellBase
/** 外部传进来的额外参数 */
@property (nonatomic, strong) NSDictionary *paraDic;
/** id */
@property (nonatomic, weak) TQLClassifyScrollVC *currentVC;

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
@property (nonatomic, assign) NSInteger pageFirst;//默认0

/** btnArray */
@property (nonatomic, strong) NSArray<TQLRedBadgeBttton *> *switchToolBtnArray;

/** itemArray */
@property (nonatomic, strong) NSArray<NSString *> *switchToolItemArray;

@property (nonatomic, strong) UIColor *mjRefreshColor;


@property (nonatomic, copy)  SuccessBlock  successBlock;
@property (nonatomic, copy)  FailureBlock  failureBlock;

@property (nonatomic, copy) ConfigTQLViewContorllerBlock configTQLVCBlock;
@property (nonatomic, assign) BOOL enableHeaderRefresh;//默认NO
@property (nonatomic, assign) BOOL enableFooterRefresh;//默认NO


/** 1...n */
@property (nonatomic, assign, readonly) NSInteger currentSwitchBtnIndex;

- (void)cellForItem:(NSInteger)row;
- (void)willDisplayRow:(NSInteger)row;
- (void)didEndDisplayRow:(NSInteger)row;
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
/*默认采用row:0-n 作为key ;可以重写改方法，针对用于一个row 对应不同数据的情况*/
- (NSString *)keyForCurrentData;
/**
 * 删除数组中的某个对象
 */
- (BOOL)deleteObjFromArrayData:(NSInteger)index needReload:(BOOL)needReload;

/**
 * 删除页面row对应的数组
 */
- (void)deleteArrayData;

- (TQLRedBadgeBttton *)currentSwitchBtn;
- (NSString *)currentSwitchItem;

- (void)sc_reciveMemoryWarningNotification:(NSNotification *)noti;
@end
