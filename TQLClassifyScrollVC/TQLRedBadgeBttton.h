//
//  TQLRedBadgeBttton.h
//  hqedu24olapp
//
//  Created by litianqi on 2018/7/25.
//  Copyright © 2018年 edu24ol. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,TQLSwitchImgAlignment)
{
    TQLSwitchImgAlignmentVerticalTop,
    TQLSwitchImgAlignmentVerticalBottom,
    TQLSwitchImgAlignmentHorizontalLeft,
    TQLSwitchImgAlignmentHorizontalRight,
    TQLSwitchImgAlignmentCenter
    
};

@protocol TQLSwitchViewItemProtocal <NSObject>
- (NSString *)itemName;
- (UIImage *)itemImgNormal;
- (UIImage *)itemImgSelected;
- (CGSize)itemImgSelectedSize;
- (CGSize)itemImgNormalSize;
///图片距离问题的间距
- (CGFloat)marginTitleForImg;

- (TQLSwitchImgAlignment)itemImgAlinmgent;

- (NSString *)itemkey;
@end

//默认类，外部可以使用
@interface TQLSwitchViewItem :NSObject<TQLSwitchViewItemProtocal>
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSInteger objId;

@end


@interface TQLRedBadgeBttton : UIButton
@property (nonatomic, strong) UILabel *lableNum;
/** num */
@property (nonatomic, assign) NSInteger redNum;
/** TQLSwitchImgAlignment */
@property (nonatomic, assign) TQLSwitchImgAlignment imgAlignment;
@property (nonatomic, strong) UIFont * normalFont;
@property (nonatomic, strong) UIFont * selectedFont;


/*
 * offset: leading & Bottom
 * offset 相当对titleLabel : trailing & top
 */
- (void)showRedPointBGColor:(UIColor *)pointColor size:(CGSize)size offSetLeadingBottom:(CGPoint)offset;

/*
  * 自定义显示数字
 */
- (void)showNumRedPoint:(NSInteger)num withPointBGColor:(UIColor *)pointColor textColor:(UIColor *)textColor font:(UIFont *)font size:(CGSize)size offSetLeadingBottom:(CGPoint)offset;
/*
 *  可以添加边框的
 */
- (void)showNumRedPoint:(NSInteger)num withPointBGColor:(UIColor *)pointColor textColor:(UIColor *)textColor font:(UIFont *)font size:(CGSize)size offSetLeadingBottom:(CGPoint)offset borderWidth:(NSInteger)borderWidth borderColor:(UIColor *)borderColor;

- (CGFloat)customCenterX;
@end
