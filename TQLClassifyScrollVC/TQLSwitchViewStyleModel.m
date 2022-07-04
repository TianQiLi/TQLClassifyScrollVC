//
//  TQLSwitchViewStyleModel.m
//  TQLNest
//
//  Created by litianqi on 2018/6/19.
//

#import "TQLSwitchViewStyleModel.h"
@interface TQLSwitchViewStyleModel()
@property (nonatomic, strong) UIFont *selectedBtn_Font;
@property (nonatomic, strong) UIFont *normalBtn_Font;
@end

@implementation TQLSwitchViewStyleModel

- (id)init
{
    if (self = [super init]) {
        _switchViewHeight = 48;
        _switchViewY = 0;
        _needSequenceStatus = NO;
        _scrollViewItemInterMargin = 5;
        _needFistRefresh = YES;
    }
    return self;
}


- (id)initSwitchButtonStyle:(UIColor *)colorNormal selectedColor:(UIColor *)colorSelected flagColor:(UIColor *)flagColor titleNormalBtnFont:(UIFont *)normalFontBtn selectedNormalBtnFont:(UIFont *)selectedFontBtn flagViewWidth:(CGSize)flagSize bottomLineColor:(UIColor *)bottomLineColor bottonLineHidden:(BOOL)hidden switchViewRect:(CGRect)switchViewRect
{
    if (self = [self init]) {
        _colorNormal = colorNormal;
        _colorSelected = colorSelected;
        _flagColor = flagColor;
       
        _selectedBtn_Font = selectedFontBtn;
        _normalBtn_Font = normalFontBtn;
        _flagSize = flagSize;
        _bottomLineColor = bottomLineColor;
        _bottomLineHidden = hidden;
        _switchViewHeight = switchViewRect.size.height;
        _switchViewY = switchViewRect.origin.y;
        
    }
    return self;
    
}

- (id)initSwitchButtonStyle:(UIColor *)colorNormal selectedColor:(UIColor *)colorSelected flagColor:(UIColor *)flagColor titleBtnFont:(UIFont *)fontBtn flagViewWidth:(CGSize)flagSize bottomLineColor:(UIColor *)bottomLineColor bottonLineHidden:(BOOL)hidden switchViewRect:(CGRect)switchViewRect
{
    return  [self initSwitchButtonStyle:colorNormal selectedColor:colorSelected flagColor:flagColor titleNormalBtnFont:fontBtn selectedNormalBtnFont:fontBtn flagViewWidth:flagSize bottomLineColor:bottomLineColor bottonLineHidden:hidden switchViewRect:switchViewRect];
}

- (UIFont *)normalBtn_Font
{
    if (!_normalBtn_Font) {
        _normalBtn_Font = [UIFont systemFontOfSize:15];
    }
    return _normalBtn_Font;
}

- (UIFont *)selectedBtn_Font
{
    if (!_selectedBtn_Font) {
        _selectedBtn_Font = [UIFont boldSystemFontOfSize:16];
    }
    return _selectedBtn_Font;
}

- (UIColor *)colorNormal
{
    if (!_colorNormal) {
        _colorNormal = [UIColor colorWithRed:48.0/255 green:49.0/255 blue:51.0/255 alpha:1.0];
    }
    return _colorNormal;
}

- (UIColor *)colorSelected
{
    if (!_colorSelected) {
        _colorSelected = [UIColor colorWithRed:57.0/255 green:143.0/255 blue:249.0/255 alpha:1.0];
    }
    return _colorSelected;
}

- (UIColor *)flagColor
{
    if (!_flagColor) {
        _flagColor = [UIColor colorWithRed:57.0/255 green:143.0/255 blue:249.0/255 alpha:1.0];
    }
    return _flagColor;
}

- (UIColor *)bottomLineColor
{
    if (!_bottomLineColor) {
        _bottomLineColor = [UIColor colorWithRed:223.0/255 green:223.0/255 blue:223.0/255 alpha:1.0];
    }
    return _bottomLineColor;
}



@end
