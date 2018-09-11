//
//  SwitchViewButton.m
//  hqedu24olapp
//
//  Created by litianqi on 16/7/21.
//  Copyright © 2016年 edu24ol. All rights reserved.
//

#import "TQLSwitchViewTool.h"
#import "TQLClassifyScrollVC_Header.h"
#import <Masonry/Masonry.h>
@interface TQLSwitchViewTool (){
    TQLSwitchViewStyleModel *_switchViewStyle;
    
}
@property (nonatomic,strong) UIScrollView * scrollView;
@property (nonatomic,strong) UIView *flagLine;
@property (nonatomic,strong) UIView * bottomLine;
@property (nonatomic, strong) TQLSwitchViewStyleModel *switchViewStyle;
/** btnArray */
@property (nonatomic, strong) NSMutableArray *buttonItemArray;


@end
@implementation TQLSwitchViewTool

- (NSArray *)btnArray{
    return self.buttonItemArray;
}

- (TQLSwitchViewStyleModel *)switchViewStyle{
    if (!_switchViewStyle) {
        _switchViewStyle = [[TQLSwitchViewStyleModel alloc] init];
    }
    return _switchViewStyle;
}

- (void)setSwitchViewStyle:(TQLSwitchViewStyleModel *)switchViewStyle{
    _switchViewStyle = switchViewStyle;
}

-(id)initWithFrame:(CGRect)frame switchViewStyle:(TQLSwitchViewStyleModel *)switchViewStyle{
    if (self = [super initWithFrame:frame]) {
        _buttonItemArray = @[].mutableCopy;
        _switchViewStyle = switchViewStyle;
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-2)];
        [_scrollView setContentSize:CGSizeMake(frame.size.width,0)];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        
        [self addSubview:_scrollView];
        
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self);
            make.trailing.equalTo(self);
            make.top.equalTo(self);
            make.bottom.equalTo(self).offset(-2);
        }];
        
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0,frame.size.width ,1)];
        [_bottomLine setBackgroundColor:self.switchViewStyle.bottomLineColor];
        [self addSubview:_bottomLine];
        _bottomLine.hidden = self.switchViewStyle.bottomLineHidden;
        [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self);
            make.trailing.equalTo(self);
            make.height.mas_equalTo(0.5);
            make.bottom.equalTo(self);
        }];
        
        self.flagLine = [[UIView alloc] initWithFrame:CGRectMake(20,self.frame.size.height-2,self.switchViewStyle.flagSize.width ,self.switchViewStyle.flagSize.height)];
        [_flagLine setBackgroundColor:self.switchViewStyle.flagColor];
        [self addSubview:_flagLine];
        
        self.cornerRadius = self.switchViewStyle.cornerRadius;
        
    }
    return self;
}

- (void)setCornerRadius:(float)cornerRadius{
    _cornerRadius = cornerRadius;
    if (_cornerRadius > 0) {
        UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(_cornerRadius, _cornerRadius)];
        
        CAShapeLayer * shapeLayer = [CAShapeLayer new];
        shapeLayer.path = path.CGPath;
        shapeLayer.frame = self.bounds;
        self.layer.mask = shapeLayer;
    }
 
}

- (void)setArrayItem:(NSArray *)arrayItem{
    [self clearSubView];
    _arrayItem = arrayItem ? arrayItem : @[];
    
    [self loadSubView];
}

- (void)clearSubView{
    if (!_arrayItem || _arrayItem.count == 0) {
        _arrayItem = @[];
        return;
    }
    for (UIView * view in _scrollView.subviews) {
        if (view.tag > 0) {
            [view removeFromSuperview];
        }
    }
}

-(void)loadSubView{
    NSInteger btnWidth =self.frame.size.width / self.arrayItem.count;
    NSInteger index = 0;
    [_buttonItemArray removeAllObjects];
    for (id obj in self.arrayItem) {
        TQLRedBadgeBttton * button  = [TQLRedBadgeBttton buttonWithType:UIButtonTypeCustom];
        [button setTitle:obj forState:UIControlStateNormal];
        [button setFrame:CGRectMake(index * btnWidth,0, btnWidth, self.frame.size.height-2)];
        [self.scrollView addSubview:button];
        if (index == 0) {
             [button setTitleColor:self.switchViewStyle.colorSelected forState:UIControlStateNormal];
             NSInteger btnTextWidth = button.titleLabel.text.length * 16;
            
            CGRect frame = self.flagLine.frame;
            frame.size.width = self.switchViewStyle.flagSize.width ? self.switchViewStyle.flagSize.width : btnTextWidth ;
            frame.size.height = self.switchViewStyle.flagSize.height ? self.switchViewStyle.flagSize.height : 2 ;
            _flagLine.frame = frame;
            _flagLine.center = CGPointMake(button.center.x,_flagLine.center.y);
        }
        else
            [button setTitleColor:self.switchViewStyle.colorNormal forState:UIControlStateNormal];
        
        [button.titleLabel setFont:self.switchViewStyle.normalBtn_Font];
        [button setTag: ++index];
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [_buttonItemArray addObject:button];
        
        
        if (self.enumerateItemBtnBlock) {
            self.enumerateItemBtnBlock(button,index);
        }
        
    }
    [self bringSubviewToFront:_flagLine];
    _currentIndex = 1;
}

-(void)clickButton:(id)sender{
    UIButton * btn = (UIButton*)sender;
    NSInteger index = [btn tag];
    self.currentIndex = index;
    if ([self.delegate respondsToSelector:@selector(clickButton:)]) {
        [self.delegate clickButton:index];
    }
}

-(void)setCurrentIndex:(NSInteger)currentIndex{
    if (currentIndex == _currentIndex) {
        return;
    }
    [self changeButtonStyle:_currentIndex withIsSelected:NO];
    _currentIndex = currentIndex;
 
    [self changeButtonStyle:_currentIndex withIsSelected:YES];
}
-(void)changeButtonStyle:(NSInteger)index  withIsSelected:(BOOL)isSelect{
    UIButton * btn = [self.scrollView viewWithTag:index];
    if (!btn || ![btn isKindOfClass:[UIButton class]]) {
        return;
    }
   
    if (isSelect) {
        
        static NSInteger temp = 0;
        NSInteger btnTextWidth = btn.titleLabel.text.length * 16;
        if (temp != btnTextWidth) {
            temp = btnTextWidth;
            CGRect frame = self.flagLine.frame;
            frame.size.width = (self.switchViewStyle.flagSize.width ? self.switchViewStyle.flagSize.width : btnTextWidth) ;
            _flagLine.frame = frame;
        }
        
        [UIView animateWithDuration:0.4 animations:^{
            self.flagLine.center = CGPointMake(btn.center.x, self.flagLine.center.y);
        } completion:nil];
        [btn setTitleColor:self.switchViewStyle.colorSelected forState:UIControlStateNormal];
        [btn.titleLabel setFont:self.switchViewStyle.selectedBtn_Font];
    }
    else{
        [btn setTitleColor:self.switchViewStyle.colorNormal forState:UIControlStateNormal];
        [btn.titleLabel setFont:self.switchViewStyle.normalBtn_Font];
    }
    
}

+ (CGSize)contentSize{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 50);

}
@end

//@implementation TQLSwitchViewButtonCollectionCell
//
//-(id)initWithFrame:(CGRect)frame{
//    if (self = [super initWithFrame:frame]) {
//        _swithchViewTool = [[TQLSwitchViewTool alloc] initWithFrame:CGRectMake(0, 0,[TQLSwitchViewTool contentSize].width, [TQLSwitchViewTool contentSize].height)];
//        _swithchViewTool.delegate = self;
//        [self.contentView addSubview:_swithchViewTool];
//    }
//    return self;
//}
//
//#pragma mark -- SwitchViewButtonDelegate
//- (void)clickButton:(NSInteger)index{
//    if ([self.delegate respondsToSelector:@selector(clickButton:)]) {
//        [self.delegate clickButton:index];
//    }
//}
//
//@end
//
//@implementation TQLSwitchViewButtonCollectionReusableViewCell
//-(id)initWithFrame:(CGRect)frame{
//    if (self = [super initWithFrame:frame]) {
//        _swithchViewTool = [[TQLSwitchViewTool alloc] initWithFrame:CGRectMake(0, 0, [TQLSwitchViewTool contentSize].width, [TQLSwitchViewTool contentSize].height)];
//        _swithchViewTool.delegate = self;
//        [self addSubview:_swithchViewTool];
//    }
//    return self;
//}
//
//-(void)setCurrentIndex:(NSInteger)currentIndex{
//    _currentIndex = currentIndex;
//    _swithchViewTool.currentIndex = _currentIndex;
//}
//#pragma mark -- SwitchViewButtonDelegate
//- (void)clickButton:(NSInteger)index{
//
//    if ([self.delegate respondsToSelector:@selector(clickButton:)]) {
//        [self.delegate clickButton:index];
//    }
//}
//
//
//
//@end
