//

//
//
//  Created by litianqi on 2017/8/25.
//  Copyright © 2017年 edu24ol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TQLSwitchViewTool.h"
#import "TQLCollectionView.h"
@class TQLSwitchViewStyleModel;
@class TQLViewContorller;

extern NSString * const SwitchBttonClickNotification;
extern NSString * const TQLCS_ReceiveMemoryWarningNotification;
typedef void(^DissmissForTQLClassifyVC) (BOOL needUpdate,NSDictionary * extDic);

typedef void(^ViewLoadBlock) ();

typedef void(^ConfigTQLViewContorllerBlock) (TQLViewContorller *vc,NSInteger row,id obj);//row :0...n

@interface TQLClassifyScrollVC : UIViewController
@property (nonatomic, strong) UIImage *navBarShadowImageHidden;
@property (nonatomic, strong) UIImage *navBarShadowImageShow;
@property (nonatomic, readonly) TQLCollectionView * collection;
@property (nonatomic, readonly) TQLSwitchViewTool * switchViewTool;
//@property (nonatomic, strong, readonly) NSArray *arrayItem;
@property (nonatomic, strong, readonly) NSArray *classCustomArray;
@property (nonatomic, strong, readonly) NSArray *cellIdentifiterArray;
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

/** 标签按钮点击回调:index= 1....n */
@property (nonatomic, copy) void (^ClickItemEventBlock)(NSInteger currentIndex,NSInteger lastIndex);
/*内存警告是否自动处理*/
@property (nonatomic, assign) BOOL memoryAutoClear;


/** 监听屏幕旋转刷新:iphone默认为NO, ipad 默认是YES */
@property (nonatomic, assign) BOOL enableRotate;

/*是否自动缓存页面自定义数据，默认为NO*/
@property (nonatomic, assign) BOOL enabelAutoCachePageData;
/*是否自动滚动<上下>嵌套的父类scrollView，默认为YES*/
@property (nonatomic, assign) BOOL enabelSuperAutoScroll;

@property (nonatomic, copy) void(^blockForDealloc)();
///拖动造成的index 改变事件回调
@property (nonatomic, copy) void(^blockChangeIndexForPanGesture)(NSInteger newIndex,NSInteger oldIndex);

- (id)initWithSwitchItemArray:(NSArray<TQLSwitchViewItemProtocal> *)arrayItem withClassArray:(NSArray<NSString *> *)classCellArray withIdentifiter:(NSArray<NSString *> *)cellIdentiArray;
/**
 * cellIdentiArray = nil ;表示不采用复用，会创建相应个数的cell
 */
- (id)initWithSwitchItemArray:(NSArray<TQLSwitchViewItemProtocal> *)arrayItem withClassArray:(NSArray<NSString *> *)classCellArray withIdentifiter:(NSArray<NSString *> *)cellIdentiArray  withRect:(CGRect)frame;

 /*配置子视图bg color*/
- (void)configViewBgColor:(UIColor *)bgColor collectionBGColor:(UIColor *)colorCollectionBG swithBtnViewBGColor:(UIColor *)colorBGSwitchBtn;


- (void)setSwitchButtonBottomMargin:(NSInteger)bottomMargin;
- (void)staticsCourseType:(NSInteger)index;

- (void)setMJRefreshBgColor:(UIColor *)mjRefreshColor;

- (void)setOrignalRect:(CGRect)orignalRect;
/*更新分类标签数组,会更新相应UI展示。如果是初始化后尾部 tab 增删，优先使用此方法*/
- (void)updateItemArray:(NSArray *)array;
/*更新分类标签数组,会更新相应UI展示。如果是初始化后中间 tab 增删，使用此方法。注意 classCellArray 与  identifiterArray应该一一对应*/
- (void)updateItemArray:(NSArray *)array classCellArray:(NSArray *)classCellArray identifiterArray:(NSArray *)identifiterArray;
/*更新分类标签数组,不更新相应容器展示*/
- (void)updateItemArrayNoReload:(NSArray *)array;

/// 增加公共参数
- (void)addParam:(NSDictionary *)param;

/// 更新指示器模式下的个数
/// @param count 个数
/// @param size  指示器大小
//- (void)updateIndicatorCount:(NSInteger)count indicatorSize:(CGSize)size;

/** 1-n
 * @param  isDefault = yes 表示首次初始化
 **/
- (void)setCurrentSwitchButtonIndex:(NSInteger)switchBtnIndex isDefault:(BOOL)isDefault;
/*
 * row: collecion 的row :0-n
 */
- (void)reloadSpecialCellReload:(NSInteger)row;
//刷新当前页面的数据
- (void)reloadCurrentPageCell;
//刷新当前页面的网络数据
- (void)forceReloadCurrentPageCellForNetWorkData;


/**
 * TQLClassifyScrollVC 容器本身刷新
 */
- (void)reload;
/*清空所有内存数据*/
- (void)removeAllData;

- (NSInteger)currentSwitchBtnIndex;

//滚动是否是按钮点击触发，否则是滑动触发
- (BOOL)scrollFromClickEvent;

/* remove view */
- (void)removeFromSuperViewWithAnimation:(void(^)())block;
/* 动画*/
- (void)showViewWithAnimation:(void(^)())block;
/*自定义collection 类*/
- (void)setCollectionClass:(NSString *)custionClassStr;
@end


