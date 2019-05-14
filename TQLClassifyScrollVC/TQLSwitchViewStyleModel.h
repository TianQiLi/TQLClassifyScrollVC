//
//  TQLSwitchViewStyleModel.h
//  TQLNest
//
//  Created by litianqi on 2018/6/19.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,TQLSwitchViewWidthStyle) {
    TQLSwitchViewWidthStyleScreen = 0,//屏幕宽度
    TQLSwitchViewWidthStyleFlexible = 1//自由:根据文字长度长度自动计算的
};


@interface TQLSwitchViewStyleModel : NSObject
/*switchButtonStyle-option*/
/** font */
@property (nonatomic, strong,readonly) UIFont *selectedBtn_Font;
@property (nonatomic, strong,readonly) UIFont *normalBtn_Font;
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
@property (nonatomic, assign) TQLSwitchViewWidthStyle scrollViewWidthStyle;
@property (nonatomic, assign) UIEdgeInsets scrollViewItemEdge;//TQLSwitchViewWidthStyleFlexible 时有效
@property (nonatomic, assign) NSInteger scrollViewItemInterMargin;//TQLSwitchViewWidthStyleFlexible 时有效


- (id)initSwitchButtonStyle:(UIColor *)colorNormal selectedColor:(UIColor *)colorSelected flagColor:(UIColor *)flagColor titleBtnFont:(UIFont *)fontBtn flagViewWidth:(CGSize)flagSize bottomLineColor:(UIColor *)bottomLineColor bottonLineHidden:(BOOL)hidden switchViewRect:(CGRect)switchViewRect;//弃用了

- (id)initSwitchButtonStyle:(UIColor *)colorNormal selectedColor:(UIColor *)colorSelected flagColor:(UIColor *)flagColor titleNormalBtnFont:(UIFont *)normalFontBtn selectedNormalBtnFont:(UIFont *)selectedFontBtn flagViewWidth:(CGSize)flagSize bottomLineColor:(UIColor *)bottomLineColor bottonLineHidden:(BOOL)hidden switchViewRect:(CGRect)switchViewRect;

@end
