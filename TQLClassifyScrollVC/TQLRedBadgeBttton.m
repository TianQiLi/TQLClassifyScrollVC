//
//  TQLRedBadgeBttton.m
//  hqedu24olapp
//
//  Created by litianqi on 2018/7/25.
//  Copyright © 2018年 edu24ol. All rights reserved.
//

#import "TQLRedBadgeBttton.h"
#import <Masonry/Masonry.h>
#import "TQLSwitchViewTool.h"

@implementation TQLSwitchViewItem
#pragma mark-- TQLSwitchViewItemProtocal

- (NSString *)itemName
{
    return _name;
}

- (NSString *)itemkey
{
    return [NSString stringWithFormat:@"%ld",_objId];
}

@end


@interface TQLRedBadgeBttton()
/** labelNum */

@end
@implementation TQLRedBadgeBttton

- (void)showRedPointBGColor:(UIColor *)pointColor size:(CGSize)size offSetLeadingBottom:(CGPoint)offset
{
    [self showNumRedPoint:0 withPointBGColor:pointColor textColor:pointColor font:nil size:size  offSetLeadingBottom:offset borderWidth:0 borderColor:nil];
}


- (void)showNumRedPoint:(NSInteger)num withPointBGColor:(UIColor *)pointColor textColor:(UIColor *)textColor font:(UIFont *)font size:(CGSize)size offSetLeadingBottom:(CGPoint)offset
{
    [self showNumRedPoint:num withPointBGColor:pointColor textColor:textColor font:font size:size offSetLeadingBottom:offset borderWidth:0 borderColor:nil];
}

- (void)showNumRedPoint:(NSInteger)num withPointBGColor:(UIColor *)pointColor textColor:(UIColor *)textColor font:(UIFont *)font size:(CGSize)size offSetLeadingBottom:(CGPoint)offset borderWidth:(NSInteger)borderWidth borderColor:(UIColor *)borderColor
{
    if (num == -1) {
        _lableNum.hidden = YES;
    } else
         _lableNum.hidden = NO;
    _redNum = num;
    if (num) {
         _lableNum.text = [NSString stringWithFormat:@"%ld",num];
    } else
         _lableNum.text = @"";
   
    _lableNum.textColor = textColor;
    if (font) {
       _lableNum.font = font;
    }
    if (pointColor) {
        [_lableNum setBackgroundColor:pointColor];
    }
    
    if (borderWidth) {
        _lableNum.layer.borderColor = borderColor ? borderColor.CGColor : [UIColor whiteColor].CGColor;
        _lableNum.layer.borderWidth = borderWidth;
    } else {
        _lableNum.layer.borderWidth = 0;
    }
    
    
   
    [_lableNum.layer setCornerRadius:size.width/2];
    [_lableNum mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(size.width);
        make.height.mas_equalTo(size.height);
        make.leading.equalTo(self.titleLabel.mas_trailing).offset(offset.x);
        make.bottom.equalTo(self.titleLabel.mas_top).offset(offset.y);
    }];
}


- (void)setRedNum:(NSInteger)redNum
{
    _redNum = redNum;
    if (redNum <= 0) {
        _lableNum.hidden = YES;
    } else
        _lableNum.hidden = NO;
    _lableNum.text = [NSString stringWithFormat:@"%ld",redNum];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        float _w = frame.size.width;
        float _h = frame.size.height;
        _lableNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        [_lableNum setBackgroundColor:[UIColor colorWithRed:254.0/255.0 green:64.0/255.0 blue:48.0/255.0 alpha:1]];
        [_lableNum setFont:[UIFont systemFontOfSize:8.0]];
        [_lableNum setCenter:CGPointMake(_w/2 + 11,_h/2 - 3)];
        [_lableNum setTextAlignment:NSTextAlignmentCenter];
        [_lableNum.layer setCornerRadius:_lableNum.frame.size.width/2];
        [_lableNum.layer setMasksToBounds:YES];
        [_lableNum setTextColor:[UIColor redColor]];
        [self addSubview:_lableNum];
        
        [_lableNum  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.titleLabel.mas_trailing).offset(1);
            make.bottom.equalTo(self.titleLabel.mas_top).offset(1);
            make.width.mas_equalTo(10);
            make.height.mas_equalTo(10);
        }];
        
        _lableNum.hidden = YES;
        
    }
    return self;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (CGFloat)customCenterX
{
    NSInteger test = CGRectGetMinX(self.frame);
    return CGRectGetMinX(self.frame) + CGRectGetMidX(self.titleLabel.frame);
    return CGRectGetMinX(self.frame) + self.titleLabel.frame.origin.x + self.titleLabel.frame.size.width/2;
//    return CGRectGetMinX(self.frame) + CGRectGetMinX(self.titleLabel.frame) + CGRectGetMidX(self.titleLabel.frame);
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        [self.titleLabel setFont:self.selectedFont];
    } else {
        [self.titleLabel setFont:self.normalFont];
    }
    
}

@end
