//
//  SwitchViewButton.m
//  hqedu24olapp
//
//  Created by litianqi on 16/7/21.
//  Copyright © 2016年 edu24ol. All rights reserved.
//

#import "TQLSwitchViewTool.h"
//#import "TQLSwitchViewStyleModel.h"
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
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [_scrollView setContentSize:CGSizeMake(frame.size.width,0)];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        
        [self addSubview:_scrollView];
        
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self);
            make.trailing.equalTo(self);
            make.top.equalTo(self);
            make.bottom.equalTo(self).offset(0);
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
        
        self.flagLine = [[UIView alloc] initWithFrame:CGRectMake(20,self.frame.size.height-self.switchViewStyle.flagSize.height - self.switchViewStyle.flagBottom,self.switchViewStyle.flagSize.width ,self.switchViewStyle.flagSize.height)];
        [_flagLine setBackgroundColor:self.switchViewStyle.flagColor];
        [_scrollView addSubview:_flagLine];
        
        if (self.switchViewStyle.flagCorner) {
            [self.flagLine.layer setMasksToBounds:YES];
            [self.flagLine.layer setCornerRadius:self.switchViewStyle.flagCorner];
        }
        
        
        self.cornerRadius = self.switchViewStyle.cornerRadius;
        
    }
    return self;
}

- (UIView *)flagView{
    return self.flagLine;
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
    NSInteger btnWidth = (self.frame.size.width - self.switchViewStyle.scrollViewItemEdge.left - self.switchViewStyle.scrollViewItemEdge.right) / self.arrayItem.count;
    NSInteger index = 0;
    [_buttonItemArray removeAllObjects];
    NSInteger lastBtnx = self.switchViewStyle.scrollViewItemEdge.left;
    NSInteger countItem = self.arrayItem.count;
    NSInteger marginLeft = self.switchViewStyle.scrollViewItemEdge.left;
    NSInteger buttonHeight = self.scrollView.frame.size.height - self.switchViewStyle.itemOffset.y;
    for (id obj in self.arrayItem) {
        TQLRedBadgeBttton * button  = [TQLRedBadgeBttton buttonWithType:UIButtonTypeCustom];
        [button setTitle:obj forState:UIControlStateNormal];
        NSInteger textWidth = 0;
        
        if (self.switchViewStyle.scrollViewWidthStyle == TQLSwitchViewWidthStyleFlexible) {
            if (index == 0) {
                textWidth = ceil(self.switchViewStyle.selectedBtn_Font.pointSize) * button.titleLabel.text.length;
            }else{
                textWidth = ceil(self.switchViewStyle.normalBtn_Font.pointSize) * button.titleLabel.text.length;
            }
            
            if (index == 0) {
                [button.titleLabel setTextAlignment:NSTextAlignmentLeft];
                btnWidth = textWidth + self.switchViewStyle.scrollViewItemInterMargin/2;
                [button setTitleEdgeInsets: UIEdgeInsetsMake(0, - self.switchViewStyle.scrollViewItemInterMargin/2, 0, 0)];
                
            }else if ((index + 1) == countItem){//last
                [button.titleLabel setTextAlignment:NSTextAlignmentRight];
                btnWidth = textWidth + self.switchViewStyle.scrollViewItemInterMargin;
                NSInteger scrollViewWidth = lastBtnx + btnWidth + self.switchViewStyle.scrollViewItemEdge.right;
                [self.scrollView setContentSize:CGSizeMake(scrollViewWidth, self.scrollView.contentSize.height)];
            }
            else{
                [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
                btnWidth = textWidth + self.switchViewStyle.scrollViewItemInterMargin;
            }
            
            [button setFrame:CGRectMake(lastBtnx,self.switchViewStyle.itemOffset.y, btnWidth, buttonHeight)];
            lastBtnx = CGRectGetMinX(button.frame) + CGRectGetWidth(button.frame);
        }else{
            [button setFrame:CGRectMake(marginLeft + index * btnWidth,self.switchViewStyle.itemOffset.y, btnWidth, buttonHeight)];
            [button.titleLabel setTextAlignment:NSTextAlignmentCenter];//默认
        }
        
        if (index == 0) {
            [button setTitleColor:self.switchViewStyle.colorSelected forState:UIControlStateNormal];
            [button.titleLabel setFont:self.switchViewStyle.selectedBtn_Font];
            NSInteger btnTextWidth = button.titleLabel.text.length * self.switchViewStyle.selectedBtn_Font.pointSize;
            
            CGRect frameFlag = self.flagLine.frame;
            frameFlag.size.width = self.switchViewStyle.flagSize.width ? self.switchViewStyle.flagSize.width : btnTextWidth ;
            frameFlag.size.height = self.switchViewStyle.flagSize.height ? self.switchViewStyle.flagSize.height : 2 ;
            
            if (button.titleLabel.textAlignment == NSTextAlignmentCenter) {
                self.flagLine.center = CGPointMake(CGRectGetMidX(button.frame),self.flagLine.center.y);
            }else if(button.titleLabel.textAlignment == NSTextAlignmentLeft){
                //                 self.flagLine.center = CGPointMake(CGRectGetMidX(button.frame) - self.switchViewStyle.scrollViewItemInterMargin/2 ,self.flagLine.center.y);
                //                 self.flagLine.center = CGPointMake(CGRectGetMidX(button.frame),self.flagLine.center.y);
                NSInteger centerX = button.center.x;
                if (centerX == 0) {
                    centerX = button.frame.origin.x + button.frame.size.width/2;
                }
                
                self.flagLine.center = CGPointMake(button.center.x - self.switchViewStyle.scrollViewItemInterMargin/4,self.flagLine.center.y);
            }else{
                NSInteger offsetx = (button.titleLabel.text.length * self.switchViewStyle.normalBtn_Font.pointSize) / 2 + 2;
                self.flagLine.center = CGPointMake(button.frame.origin.x + button.frame.size.width - offsetx ,self.flagLine.center.y);
            }
            
        }
        else{
            [button setTitleColor:self.switchViewStyle.colorNormal forState:UIControlStateNormal];
            [button.titleLabel setFont:self.switchViewStyle.normalBtn_Font];
        }
        [button setTag: ++index];
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [_buttonItemArray addObject:button];
        [self.scrollView addSubview:button];
        
        
        if (self.enumerateItemBtnBlock) {
            self.enumerateItemBtnBlock(button,index);
        }
        
    }
    [self bringSubviewToFront:_flagLine];
    _currentIndex = 1;
}

-(void)clickButton:(id)sender{
    UIButton * button = (UIButton*)sender;
    NSInteger index = [button tag];
    //    [self updateButtonFrame:index];
    self.currentIndex = index;
    
    if ([self.delegate respondsToSelector:@selector(clickButton:)]) {
        [self.delegate clickButton:index];
    }
}

- (void)updateButtonFrame:(NSInteger )selectedIndex{
    selectedIndex -= 1;
    if (selectedIndex < 0) {
        return;
    }
    
    if (self.switchViewStyle.scrollViewWidthStyle != TQLSwitchViewWidthStyleFlexible) {
        return;
    }
    NSInteger index = 0;
    NSInteger btnWidth = 0,countItem = 0;
    NSInteger lastBtnx = self.switchViewStyle.scrollViewItemEdge.left;
    for (UIButton * button in self.buttonItemArray) {
        if (self.switchViewStyle.scrollViewWidthStyle == TQLSwitchViewWidthStyleFlexible) {
            NSInteger textWidth = 0;
            if (index == selectedIndex) {
                textWidth = ceil(self.switchViewStyle.selectedBtn_Font.pointSize) * button.titleLabel.text.length;
            }else{
                textWidth = ceil(self.switchViewStyle.normalBtn_Font.pointSize) * button.titleLabel.text.length;
            }
            
            if (index == 0) {
                btnWidth = textWidth + self.switchViewStyle.scrollViewItemInterMargin/2;
                [button.titleLabel setTextAlignment:NSTextAlignmentLeft];
            }else if ((index + 1) == countItem){//last
                //                [button.titleLabel setTextAlignment:NSTextAlignmentRight];
                btnWidth = textWidth + self.switchViewStyle.scrollViewItemInterMargin;
                NSInteger scrollViewWidth = lastBtnx + btnWidth + self.switchViewStyle.scrollViewItemEdge.right;
                [self.scrollView setContentSize:CGSizeMake(scrollViewWidth, self.scrollView.contentSize.height)];
            }
            else{
                //                [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
                btnWidth = textWidth + self.switchViewStyle.scrollViewItemInterMargin;
            }
            CGRect frame = button.frame;
            frame.origin.x = lastBtnx;
            frame.size.width = btnWidth;
            [button setFrame:frame];
            lastBtnx = CGRectGetMinX(button.frame) + CGRectGetWidth(button.frame);
        }
        index ++;
    }
    
}

-(void)setCurrentIndex:(NSInteger)currentIndex{
    if (currentIndex == _currentIndex) {
        return;
    }
    [self updateButtonFrame:currentIndex];
    
    [self changeButtonStyle:_currentIndex withIsSelected:NO];
    _currentIndex = currentIndex;
    
    [self changeButtonStyle:_currentIndex withIsSelected:YES];
    
    if (self.switchViewStyle.needSequenceStatus) {
        [self.btnArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx > (_currentIndex - 1)) {
                [obj setTitleColor:self.switchViewStyle.colorNormal forState:UIControlStateNormal];
            }else{
                [obj setTitleColor:self.switchViewStyle.colorSelected forState:UIControlStateNormal];
            }
        }];
    }
    
}

-(void)changeButtonStyle:(NSInteger)index  withIsSelected:(BOOL)isSelect{
    UIButton * button = [self.scrollView viewWithTag:index];
    if (!button || ![button isKindOfClass:[UIButton class]]) {
        return;
    }
    
    if (isSelect) {
        //TODO: 调整button 的位置
        NSInteger currentOffsetx = self.scrollView.contentOffset.x;
        NSInteger absluteX = 0;
        if (button.center.x < self.scrollView.bounds.size.width/2) {
            absluteX = CGRectGetMinX(button.frame) - currentOffsetx;
        }else{
            absluteX = CGRectGetMaxX(button.frame) - currentOffsetx;
        }
        
        if (absluteX > self.scrollView.frame.size.width) {//偏右
            absluteX = absluteX - self.scrollView.frame.size.width + button.bounds.size.width;
            NSInteger offsetx = MIN(currentOffsetx + absluteX + CGRectGetWidth(button.frame), self.scrollView.contentSize.width - self.scrollView.frame.size.width);
            [self.scrollView setContentOffset:CGPointMake(offsetx ,0) animated:YES];
        }else if (absluteX < CGRectGetWidth(button.frame)){//偏左
            NSInteger offsetx = currentOffsetx + absluteX;
            offsetx = MAX(offsetx - CGRectGetWidth(button.frame), 0);
            [self.scrollView setContentOffset:CGPointMake(offsetx,0) animated:YES];
        }else if (_scrollView.contentOffset.x < 0){
            [self.scrollView setContentOffset:CGPointMake(0,0) animated:YES];
        }
        
        static NSInteger temp = 0;
        NSInteger btnTextWidth = button.titleLabel.text.length * self.switchViewStyle.normalBtn_Font.pointSize;
        if (temp != btnTextWidth) {
            temp = btnTextWidth;
            __block CGRect frameFlag = self.flagLine.frame;
            frameFlag.size.width = (self.switchViewStyle.flagSize.width ? self.switchViewStyle.flagSize.width : btnTextWidth) ;
            _flagLine.frame = frameFlag;
        }
        
        [UIView animateWithDuration:0.4 animations:^{
            if (button.titleLabel.textAlignment == NSTextAlignmentCenter) {
                self.flagLine.center = CGPointMake(button.center.x,self.flagLine.center.y);
            }else if (button.titleLabel.textAlignment == NSTextAlignmentLeft) {
                self.flagLine.center = CGPointMake(button.center.x - self.switchViewStyle.scrollViewItemInterMargin/4,self.flagLine.center.y);
            }
            else{
                self.flagLine.center = CGPointMake(button.center.x,self.flagLine.center.y);
            }
            
        } completion:nil];
        [button setTitleColor:self.switchViewStyle.colorSelected forState:UIControlStateNormal];
        [button.titleLabel setFont:self.switchViewStyle.selectedBtn_Font];
    }
    else{
        [button setTitleColor:self.switchViewStyle.colorNormal forState:UIControlStateNormal];
        [button.titleLabel setFont:self.switchViewStyle.normalBtn_Font];
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

