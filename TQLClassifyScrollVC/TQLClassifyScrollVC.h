//

//
//
//  Created by litianqi on 2017/8/25.
//  Copyright © 2017年 edu24ol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TQLSwitchViewTool.h"
@class TQLSwitchViewStyleModel;
//@class TQLSwitchViewTool;
extern NSString * const SwitchBttonClickNotification;
typedef void(^DissmissForTQLClassifyVC) (BOOL needUpdate,NSDictionary * extDic);
@interface TQLClassifyScrollVC : UIViewController
@property (nonatomic, strong) UIImage *navBarShadowImageHidden;
@property (nonatomic, strong) UIImage *navBarShadowImageShow;
@property (nonatomic, readonly) UICollectionView * collection;
@property (nonatomic, readonly) TQLSwitchViewTool * switchViewTool;
/** switchViewStyle.switchViewY > 0 才会初始化*/
@property (nonatomic, strong) UIView *maskView;

/**collection scroll by SwitchClick NO ; enable scroll animation */
@property (nonatomic, assign) BOOL enableScollForSwitchClick;//default:NO
/**when enableScollForSwitchClick = yes, justTwoScrollForSwitchClick is yes ,animation happen in two cell ;else hapen more cell */
@property (nonatomic, assign) BOOL justTwoScrollForSwitchClick;//default:YES

/** TQLSwitchViewStyleModel */
@property (nonatomic, strong) TQLSwitchViewStyleModel *switchViewStyle;
/** paramater */
@property (nonatomic, strong) NSDictionary *paramaterDic;

@property (nonatomic, copy) EnumerateItemBtnBlock enumerateItemBtnBlock;
@property (nonatomic, copy) DissmissForTQLClassifyVC  dissmissCompletion;

/** 监听屏幕旋转刷新:默认为NO */
@property (nonatomic, assign) BOOL enableRotate;
@property (nonatomic, copy) void(^blockForDealloc)();


- (id)initWithSwitchItemArray:(NSArray<NSString *> *)arrayItem withClassArray:(NSArray<NSString *> *)classCellArray withIdentifiter:(NSArray<NSString *> *)cellIdentiArray;
/**
 * cellIdentiArray = nil ;表示不采用复用，会创建相应个数的cell
 */
- (id)initWithSwitchItemArray:(NSArray<NSString *> *)arrayItem withClassArray:(NSArray<NSString *> *)classCellArray withIdentifiter:(NSArray<NSString *> *)cellIdentiArray  withRect:(CGRect)frame;

 /*配置子视图bg color*/
- (void)configViewBgColor:(UIColor *)bgColor collectionBGColor:(UIColor *)colorCollectionBG swithBtnViewBGColor:(UIColor *)colorBGSwitchBtn;


- (void)setSwitchButtonBottomMargin:(NSInteger)bottomMargin;
- (void)staticsCourseType:(NSInteger)index;

- (void)setMJRefreshBgColor:(UIColor *)mjRefreshColor;

- (void)setOrignalRect:(CGRect)orignalRect;
/** 1-n
 * @param  isDefault = yes 表示首次初始化
 **/
- (void)setCurrentSwitchButtonIndex:(NSInteger)switchBtnIndex isDefault:(BOOL)isDefault;
/*
 * row: collecion 的row :0-n
 */
- (void)reloadSpecialCellReload:(NSInteger)row;
/**
 * TQLClassifyScrollVC 容器本身刷新
 */
- (void)reload;
/*清空所有内存数据*/
- (void)removeAllData;

- (NSInteger)currentSwitchBtnIndex;
@end
