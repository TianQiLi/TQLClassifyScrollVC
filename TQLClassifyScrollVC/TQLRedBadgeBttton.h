//
//  TQLRedBadgeBttton.h
//  hqedu24olapp
//
//  Created by litianqi on 2018/7/25.
//  Copyright © 2018年 edu24ol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TQLRedBadgeBttton : UIButton
@property (nonatomic, strong) UILabel *lableNum;
/** num */
@property (nonatomic, assign) NSInteger redNum;
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
@end
