//

//
//
//  Created by litianqi on 2017/8/25.
//  Copyright © 2017年 edu24ol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TQLSwitchViewTool.h"
@class TQLSwitchViewStyleModel;
@class TQLViewContorller;

extern NSString * const SwitchBttonClickNotification;
typedef void(^DissmissForTQLClassifyVC) (BOOL needUpdate,NSDictionary * extDic);

typedef void(^ViewLoadBlock) ();

typedef void(^ConfigTQLViewContorllerBlock) (TQLViewContorller *vc,NSInteger row,id obj);//row :0...n

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
/**  */
@property (nonatomic, copy) ViewLoadBlock viewDidLoadBlock;

@property (nonatomic, copy) ViewLoadBlock viewWillAppearBlock;
@property (nonatomic, copy) ViewLoadBlock viewDidAppearBlock;
@property (nonatomic, copy) ViewLoadBlock viewWillDisappearBlock;
@property (nonatomic, copy) ViewLoadBlock viewDidDisappearBlock;
/** 配置自定义的c控制器：比如传参*/
@property (nonatomic, copy) ConfigTQLViewContorllerBlock configTQLVCBlock;

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
/* remove view */
- (void)removeFromSuperViewWithAnimation:(void(^)())block;
/* 动画*/
- (void)showViewWithAnimation:(void(^)())block;
@end
