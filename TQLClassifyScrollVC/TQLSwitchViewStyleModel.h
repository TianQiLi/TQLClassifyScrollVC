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
@property (nonatomic, strong) UIFont *customBtnFont;

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

@property (nonatomic, assign) NSInteger switchViewHeight;//switchViewHeight : default:48

- (id)initSwitchButtonStyle:(UIColor *)colorNormal selectedColor:(UIColor *)colorSelected flagColor:(UIColor *)flagColor titleBtnFont:(UIFont *)fontBtn flagViewWidth:(CGSize)flagSize bottomLineColor:(UIColor *)bottomLineColor bottonLineHidden:(BOOL)hidden switchViewHeight:(NSInteger)switchViewHeight;
@end
