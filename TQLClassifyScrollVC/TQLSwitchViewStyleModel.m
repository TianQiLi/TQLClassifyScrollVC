//
//  TQLSwitchViewStyleModel.m
//  TQLNest
//
//  Created by litianqi on 2018/6/19.
//

#import "TQLSwitchViewStyleModel.h"

@implementation TQLSwitchViewStyleModel

- (id)init{
    if (self = [super init]) {
        _switchViewHeight = 48;
         
    }
    return self;
}

- (id)initSwitchButtonStyle:(UIColor *)colorNormal selectedColor:(UIColor *)colorSelected flagColor:(UIColor *)flagColor titleBtnFont:(UIFont *)fontBtn flagViewWidth:(CGSize)flagSize bottomLineColor:(UIColor *)bottomLineColor bottonLineHidden:(BOOL)hidden switchViewHeight:(NSInteger)switchViewHeight{
    if (self = [self init]) {
        _colorNormal = colorNormal;
        _colorSelected = colorSelected;
        _flagColor = flagColor;
        _customBtnFont = fontBtn;
        _flagSize = flagSize;
        
        _bottomLineColor = bottomLineColor;
        _bottomLineHidden = hidden;
        _switchViewHeight = switchViewHeight;

    }
    return self;
}

- (UIFont *)customBtnFont{
    if (!_customBtnFont) {
        _customBtnFont = [UIFont systemFontOfSize:16];
    }
    return _customBtnFont;
}

- (UIColor *)colorNormal{
    if (!_colorNormal) {
        _colorNormal = [UIColor colorWithRed:48.0/255 green:49.0/255 blue:51.0/255 alpha:1.0];
    }
    return _colorNormal;
}

- (UIColor *)colorSelected{
    if (!_colorSelected) {
        _colorSelected = [UIColor colorWithRed:57.0/255 green:143.0/255 blue:249.0/255 alpha:1.0];
    }
    return _colorSelected;
}

- (UIColor *)flagColor{
    if (!_flagColor) {
        _flagColor = [UIColor colorWithRed:57.0/255 green:143.0/255 blue:249.0/255 alpha:1.0];
    }
    return _flagColor;
}

- (UIColor *)bottomLineColor{
    if (!_bottomLineColor) {
        _bottomLineColor = [UIColor colorWithRed:223.0/255 green:223.0/255 blue:223.0/255 alpha:1.0];
    }
    return _bottomLineColor;
}



@end
