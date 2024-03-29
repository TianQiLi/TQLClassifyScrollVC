//
//  TQLSwitchViewStyleModel.h
//  TQLNest
//
//  Created by litianqi on 2018/6/19.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,TQLSwitchViewWidthStyle) {
    TQLSwitchViewWidthStyleScreen = 0, //屏幕宽度
    TQLSwitchViewWidthStyleFlexible = 1, //自由:根据文字长度长度自动计算的
    TQLSwitchViewWidthStyleFixedButtonWidth = 2 //固定按钮宽度
};

typedef  NS_ENUM(NSInteger , TQLSwitchStyle) {
    TQLSwitchStyleText,     ///文本按钮
    TQLSwitchStyleIndicator,///指示器
};

NS_ASSUME_NONNULL_BEGIN
@interface TQLSwitchViewStyleModel : NSObject
//是否需要首次有下拉刷新的效果， 默认YES,前提是配置了下拉刷新特性
@property (nonatomic, assign) BOOL needFistRefresh;
/*switchButtonStyle-option*/
/** font */
@property (nonatomic, strong,readonly) UIFont *selectedBtn_Font;
@property (nonatomic, strong,readonly) UIFont *normalBtn_Font;
/*文字最大长度-默认0 不处理 */
@property (nonatomic, assign) NSInteger maxItemNameLength;

/*option */
@property (nonatomic, strong) UIColor *colorNormal;
/*option */
@property (nonatomic, strong) UIColor *colorSelected;

/*option */
@property (nonatomic, strong) UIColor *flagColor;
/** flagSize */
@property (nonatomic, assign) CGSize flagSize;
/*距离底部的高度*/
@property (nonatomic, assign) CGFloat flagBottom;
@property (nonatomic, assign) CGFloat flagCorner;

/* button 显示的位置上下偏移量 */
@property (nonatomic, assign) CGPoint  itemOffset;

@property (nonatomic, strong) UIColor *bottomLineColor;
/** bottomLine hidden */
@property (nonatomic, assign) BOOL bottomLineHidden;

@property (nonatomic, assign) float cornerRadius;

@property (nonatomic, assign,readonly) NSInteger switchViewHeight;//switchViewHeight : default:48
@property (nonatomic, assign,readonly) NSInteger switchViewY;//switchViewY

/** needSequenceStatus:默认为NO,除了当前的按钮样式选中之外，之前的也处于一个选中的样式*/
@property (nonatomic, assign) BOOL needSequenceStatus;
/**
 采用TQLSwitchViewWidthStyleFlexible 时，需要设置scrollViewItemEdge & scrollViewItemInterMargin
 */
@property (nonatomic, assign) TQLSwitchViewWidthStyle scrollViewWidthStyle;
/**文本还是纯指示条样式<##>*/
@property (nonatomic, assign) TQLSwitchStyle swithchStyle;

/* 默认值0 ： scroll控件边框四周间距*/
@property (nonatomic, assign) UIEdgeInsets scrollViewItemEdge;//TQLSwitchViewWidthStyleFlexible 时有效
/* 默认值5：元素间距*/
@property (nonatomic, assign) NSInteger scrollViewItemInterMargin;//TQLSwitchViewWidthStyleFlexible 时有效

@property (nonatomic, assign) NSInteger buttonItemWidth;//TQLSwitchViewWidthStyleFixedButtonWidth 时有效

/** super scrollView maxOffsetY  */
@property (nonatomic, assign) NSInteger maxOffsetY;
@property (nonatomic, assign) NSInteger countItem;



- (id)initSwitchButtonStyle:(UIColor *)colorNormal selectedColor:(UIColor *)colorSelected flagColor:(UIColor *)flagColor titleBtnFont:(UIFont *)fontBtn flagViewWidth:(CGSize)flagSize bottomLineColor:(UIColor *)bottomLineColor bottonLineHidden:(BOOL)hidden switchViewRect:(CGRect)switchViewRect;//弃用了

- (id)initSwitchButtonStyle:(UIColor *)colorNormal selectedColor:(UIColor *)colorSelected flagColor:(UIColor *)flagColor titleNormalBtnFont:(UIFont *)normalFontBtn selectedNormalBtnFont:(UIFont *)selectedFontBtn flagViewWidth:(CGSize)flagSize bottomLineColor:(UIColor *)bottomLineColor bottonLineHidden:(BOOL)hidden switchViewRect:(CGRect)switchViewRect;


/// 多个指示条样式
/// - Parameters:
///   - count: 个数
///   - colorNormal: 颜色
///   - colorSelected: 颜色
///   - size: 大小
///   - switchViewRect: 大小
- (id)initIndicatorSwitchWithCount:(NSInteger)count normalColor:(UIColor *)colorNormal  selectedColor:(UIColor *)colorSelected   indicatorSize:(CGSize)size  switchViewRect:(CGRect)switchViewRect;

@end

NS_ASSUME_NONNULL_END
