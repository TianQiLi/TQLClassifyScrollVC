//
//  TQLSwitchViewStyleModel.h
//  TQLNest
//
//  Created by litianqi on 2018/6/19.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
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


@property (nonatomic, strong) UIColor *bottomLineColor;
/** bottomLine hidden */
@property (nonatomic, assign) BOOL bottomLineHidden;

@property (nonatomic, assign) float cornerRadius;

@property (nonatomic, assign,readonly) NSInteger switchViewHeight;//switchViewHeight : default:48
@property (nonatomic, assign,readonly) NSInteger switchViewY;//switchViewHeight : default:48

- (id)initSwitchButtonStyle:(UIColor *)colorNormal selectedColor:(UIColor *)colorSelected flagColor:(UIColor *)flagColor titleBtnFont:(UIFont *)fontBtn flagViewWidth:(CGSize)flagSize bottomLineColor:(UIColor *)bottomLineColor bottonLineHidden:(BOOL)hidden switchViewRect:(CGRect)switchViewRect;

- (id)initSwitchButtonStyle:(UIColor *)colorNormal selectedColor:(UIColor *)colorSelected flagColor:(UIColor *)flagColor titleNormalBtnFont:(UIFont *)normalFontBtn selectedNormalBtnFont:(UIFont *)selectedFontBtn flagViewWidth:(CGSize)flagSize bottomLineColor:(UIColor *)bottomLineColor bottonLineHidden:(BOOL)hidden switchViewRect:(CGRect)switchViewRect;

@end
