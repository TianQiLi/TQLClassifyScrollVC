//
//  SwitchViewButton.m
//  hqedu24olapp
//
//  Created by litianqi on 16/7/21.
//  Copyright © 2016年 edu24ol. All rights reserved.
//

#import "TQLSwitchViewTool.h"
#import "TQLScreen.h"

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
    
    NSMutableArray * results = @[].mutableCopy;
    NSInteger maxLength = self.switchViewStyle.maxItemNameLength;
    if (maxLength > 0) {
        [_arrayItem enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            NSString * name = @"";
            if (![obj isKindOfClass:[NSString class]] && [obj respondsToSelector:@selector(itemName)]) {
                name = [obj itemName];
            }else if([obj isKindOfClass:[NSString class]]){
                name =  obj;
            }
            
            if (name.length > maxLength) {
                name = [name substringWithRange:NSMakeRange(0, MIN(name.length, maxLength))];
                name = [name stringByAppendingString:@"..."];
            }
            if (name.length > 0) {
                [results addObject:name];
            }
            
        }];
        _arrayItem = results.copy;
    }

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

- (void)updateButtonFrameAfterRotate
{
    //仅考虑ipad的横竖屏切换
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
        return;
    }

    if (self.switchViewStyle.scrollViewWidthStyle != TQLSwitchViewWidthStyleScreen) {
        return;
    }
    
    //只有根据屏幕宽度适配的才需要更新
    NSInteger btnWidth = (TQLScreenBound().width - self.switchViewStyle.scrollViewItemEdge.left - self.switchViewStyle.scrollViewItemEdge.right) / self.arrayItem.count;
    NSInteger index = 0;
    NSInteger lastBtnx = self.switchViewStyle.scrollViewItemEdge.left;
    NSInteger countItem = self.arrayItem.count;
    NSInteger marginLeft = self.switchViewStyle.scrollViewItemEdge.left;
    NSInteger buttonHeight = self.scrollView.frame.size.height - self.switchViewStyle.itemOffset.y;
    
    for (TQLRedBadgeBttton *button in self.buttonItemArray) {
        [button setFrame:CGRectMake(marginLeft + index * btnWidth,self.switchViewStyle.itemOffset.y, btnWidth, buttonHeight)];
        index++;
    }

    //更新flagline的位置
    index = self.currentIndex - 1;
    if (index < 0 || index >= self.buttonItemArray.count) {
        index = 0;
    }
    
    UIButton *button = self.buttonItemArray[index];
    [self updateFlagLineFrame:button];
}

- (void)updateFlagLineFrame:(UIButton *)button
{
    NSInteger btnTextWidth = button.titleLabel.text.length * self.switchViewStyle.selectedBtn_Font.pointSize;
    CGRect frameFlag = self.flagLine.frame;
    frameFlag.size.width = self.switchViewStyle.flagSize.width ? self.switchViewStyle.flagSize.width : btnTextWidth ;
    frameFlag.size.height = self.switchViewStyle.flagSize.height ? self.switchViewStyle.flagSize.height : 2 ;
    
    if (button.titleLabel.textAlignment == NSTextAlignmentCenter) {
        self.flagLine.center = CGPointMake(CGRectGetMidX(button.frame),self.flagLine.center.y);
    }
    else if(button.titleLabel.textAlignment == NSTextAlignmentLeft) {
        NSInteger centerX = button.center.x;
        if (centerX == 0) {
            centerX = button.frame.origin.x + button.frame.size.width/2;
        }
        self.flagLine.center = CGPointMake(button.center.x - self.switchViewStyle.scrollViewItemInterMargin/4,self.flagLine.center.y);
    }
    else {
        NSInteger offsetx = (button.titleLabel.text.length * self.switchViewStyle.normalBtn_Font.pointSize) / 2 + 2;
        self.flagLine.center = CGPointMake(button.frame.origin.x + button.frame.size.width - offsetx ,self.flagLine.center.y);
    }
}

+ (BOOL)isVertical:(TQLSwitchImgAlignment)type
{
    BOOL isVertical = NO;
    switch (type) {
        case TQLSwitchImgAlignmentVerticalTop:
        case TQLSwitchImgAlignmentVerticalBottom:{
            isVertical = YES;
            break;
        }
        default:
            break;
    }
    return isVertical;
}

+ (CGFloat)getImgWidth:(id<TQLSwitchViewItemProtocal>)obj button:(TQLRedBadgeBttton *)button isSelected:(BOOL)isSelected
{
    if ([obj isKindOfClass:[NSString class]]) {
        return 0;
    }
    BOOL haveImg = NO;
    CGFloat imgWith = 0;
    if ([obj respondsToSelector:@selector(itemImgNormal)] && [obj itemImgNormal]) {
        haveImg = YES;
        [button setImage:[obj itemImgNormal] forState:UIControlStateNormal];
    }
    
    if ([obj respondsToSelector:@selector(itemImgSelected)] && [obj itemImgSelected]) {
        haveImg = YES;
        [button setImage:[obj itemImgSelected] forState:UIControlStateSelected];
    }
    
    if (haveImg && [obj respondsToSelector:@selector(itemImgNormalSize)]) {
        imgWith = [obj itemImgNormalSize].width;
        if (isSelected && [obj respondsToSelector:@selector(itemImgSelectedSize)]) {
            imgWith = [obj itemImgSelectedSize].width;
        }
        if ([obj respondsToSelector:@selector(itemImgAlinmgent)]) {
            TQLSwitchImgAlignment type = [obj itemImgAlinmgent];
            if ([[self class]isVertical:type]) {
                imgWith = 0;
            }
            if ([obj respondsToSelector:@selector(marginTitleForImg)]) {
                CGFloat margin  = [obj marginTitleForImg];
                
                if (type == TQLSwitchImgAlignmentHorizontalLeft) {
                    [button setImageEdgeInsets:UIEdgeInsetsMake(0, margin, 0, 0)];
                }else if (type == TQLSwitchImgAlignmentHorizontalRight) {
                    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, margin)];
                }else if (type == TQLSwitchImgAlignmentVerticalTop) {
                    [button setImageEdgeInsets:UIEdgeInsetsMake(margin, 0, 0, 0)];
                }else if (type == TQLSwitchImgAlignmentVerticalBottom) {
                    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, margin, 0)];
                }
            }
            
        }
        //图片间距
        if (imgWith && [obj respondsToSelector:@selector(marginTitleForImg)]) {
            imgWith += [obj marginTitleForImg];
        }
    }
   
    
    return imgWith;
    
}

-(void)loadSubView{
    NSInteger btnWidth = (self.frame.size.width - self.switchViewStyle.scrollViewItemEdge.left - self.switchViewStyle.scrollViewItemEdge.right) / self.arrayItem.count;
    NSInteger index = 0;
    [_buttonItemArray removeAllObjects];
    NSInteger lastBtnx = self.switchViewStyle.scrollViewItemEdge.left;
    NSInteger countItem = self.arrayItem.count;
    NSInteger marginLeft = self.switchViewStyle.scrollViewItemEdge.left;
    NSInteger buttonHeight = self.scrollView.frame.size.height - self.switchViewStyle.itemOffset.y;
    for (id<TQLSwitchViewItemProtocal> obj in self.arrayItem) {
        NSString * name = @"";
        if ([obj isKindOfClass:[NSString class]]) {
            name = obj;
        }else if ([obj respondsToSelector:@selector(itemName)]){
            name = [obj itemName];
        }
    
        TQLRedBadgeBttton * button  = [TQLRedBadgeBttton buttonWithType:UIButtonTypeCustom];
        [button setTitle:name forState:UIControlStateNormal];
         
        CGFloat imgWith = [[self class] getImgWidth:obj button:button isSelected:NO];
        ///TODO: 这里需要完善关于图片的布局问题，默认是左布局
        
        NSInteger textWidth = 0;
        if (self.switchViewStyle.scrollViewWidthStyle == TQLSwitchViewWidthStyleFlexible) {
            if (index == 0) {
                textWidth = ceil(self.switchViewStyle.selectedBtn_Font.pointSize) * button.titleLabel.text.length;
            }else{
                textWidth = ceil(self.switchViewStyle.normalBtn_Font.pointSize) * button.titleLabel.text.length;
            }
            
            if (index == 0) {
                [button.titleLabel setTextAlignment:NSTextAlignmentLeft];
                btnWidth = textWidth + self.switchViewStyle.scrollViewItemInterMargin/2 + imgWith;
                [button setTitleEdgeInsets: UIEdgeInsetsMake(0, - self.switchViewStyle.scrollViewItemInterMargin/2, 0, 0)];
                
            }else if ((index + 1) == countItem){//last
                [button.titleLabel setTextAlignment:NSTextAlignmentRight];
                btnWidth = textWidth + self.switchViewStyle.scrollViewItemInterMargin + imgWith;
                NSInteger scrollViewWidth = lastBtnx + btnWidth + self.switchViewStyle.scrollViewItemEdge.right;
                [self.scrollView setContentSize:CGSizeMake(scrollViewWidth, self.scrollView.contentSize.height)];
            }
            else{
                [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
                btnWidth = textWidth + self.switchViewStyle.scrollViewItemInterMargin + imgWith;
            }
            
            [button setFrame:CGRectMake(lastBtnx,self.switchViewStyle.itemOffset.y, btnWidth, buttonHeight)];
            lastBtnx = CGRectGetMaxX(button.frame);
        }else if (self.switchViewStyle.scrollViewWidthStyle == TQLSwitchViewWidthStyleFixedButtonWidth) {
              [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
            if (self.switchViewStyle.buttonItemWidth) {
                btnWidth = self.switchViewStyle.buttonItemWidth + self.switchViewStyle.scrollViewItemInterMargin;
            }else{
                btnWidth = name.length * self.switchViewStyle.selectedBtn_Font.pointSize;
            }
            
            [button setFrame:CGRectMake(lastBtnx,self.switchViewStyle.itemOffset.y, btnWidth, buttonHeight)];
            lastBtnx = CGRectGetMaxX(button.frame);
            
            if ((index + 1) == countItem){//last
                btnWidth = textWidth + self.switchViewStyle.scrollViewItemInterMargin ;
                NSInteger scrollViewWidth = lastBtnx + btnWidth + self.switchViewStyle.scrollViewItemEdge.right;
                [self.scrollView setContentSize:CGSizeMake(scrollViewWidth, self.scrollView.contentSize.height)];
            }

        }else{
            [button setFrame:CGRectMake(marginLeft + index * btnWidth,self.switchViewStyle.itemOffset.y, btnWidth, buttonHeight)];
            [button.titleLabel setTextAlignment:NSTextAlignmentCenter];//默认
        }
        
        if (index == 0) {
            [button setTitleColor:self.switchViewStyle.colorSelected forState:UIControlStateNormal];
            [button.titleLabel setFont:self.switchViewStyle.selectedBtn_Font];
            [self updateFlagLineFrame:button];
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

- (void)updateButtonFrame:(NSInteger)selectedIndex{
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
 
            id<TQLSwitchViewItemProtocal> obj = self.arrayItem[index];
            CGFloat imgWith  = [[self class] getImgWidth:obj button:button isSelected:NO];
            if (index == selectedIndex) {
                imgWith = [[self class] getImgWidth:obj button:button isSelected:YES];//选中
                textWidth = ceil(self.switchViewStyle.selectedBtn_Font.pointSize) * button.titleLabel.text.length;
            }else{
                textWidth = ceil(self.switchViewStyle.normalBtn_Font.pointSize) * button.titleLabel.text.length;
            }
            
            if (index == 0) {
                btnWidth = textWidth + self.switchViewStyle.scrollViewItemInterMargin/2 + imgWith;
                [button.titleLabel setTextAlignment:NSTextAlignmentLeft];
            }else if ((index + 1) == countItem){//last
                //                [button.titleLabel setTextAlignment:NSTextAlignmentRight];
                btnWidth = textWidth + self.switchViewStyle.scrollViewItemInterMargin + imgWith;
                NSInteger scrollViewWidth = lastBtnx + btnWidth + self.switchViewStyle.scrollViewItemEdge.right;
                [self.scrollView setContentSize:CGSizeMake(scrollViewWidth, self.scrollView.contentSize.height)];
            }
            else{
                //                [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
                btnWidth = textWidth + self.switchViewStyle.scrollViewItemInterMargin + imgWith;
            }
          
            btnWidth = btnWidth ;
            CGRect frame = button.frame;
            frame.origin.x = lastBtnx;
            frame.size.width = btnWidth;
            [button setFrame:frame];
            lastBtnx = CGRectGetMaxX(button.frame);
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
        
        if (absluteX > self.scrollView.frame.size.width-self.switchViewStyle.scrollViewItemEdge.right) {//偏右
           //            absluteX = absluteX - self.scrollView.frame.size.width + button.bounds.size.width;
//            NSInteger offsetx = MIN(currentOffsetx + absluteX + CGRectGetWidth(button.frame), self.scrollView.contentSize.width - self.scrollView.frame.size.width);
            NSInteger offsetx = MIN(CGRectGetMinX(button.frame), self.scrollView.contentSize.width - self.scrollView.frame.size.width);
            [self.scrollView setContentOffset:CGPointMake(offsetx ,0) animated:YES];
        }else if (absluteX < CGRectGetWidth(button.frame)){//偏左
            NSInteger offsetx = currentOffsetx + absluteX;
            offsetx = MAX(offsetx - CGRectGetWidth(button.frame), 0);
            [self.scrollView setContentOffset:CGPointMake(offsetx,0) animated:YES];
        }else if (_scrollView.contentOffset.x < 0){
            [self.scrollView setContentOffset:CGPointMake(0,0) animated:YES];
        }
        //统一居中处理
//        CGFloat offsetX = button.center.x-self.scrollView.bounds.size.width*0.5;
//        if (offsetX<0) {
//            offsetX = 0;
//        }
//        if (offsetX>(self.scrollView.contentSize.width-self.scrollView.bounds.size.width)) {
//            offsetX = (self.scrollView.contentSize.width-self.scrollView.bounds.size.width);
//        }
//        [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
        
        //end-居中
        
        
        static NSInteger temp = 0;
        NSInteger btnTextWidth = button.titleLabel.text.length * self.switchViewStyle.normalBtn_Font.pointSize;
        if (temp != btnTextWidth) {
            temp = btnTextWidth;
            __block CGRect frameFlag = self.flagLine.frame;
            frameFlag.size.width = (self.switchViewStyle.flagSize.width ? self.switchViewStyle.flagSize.width : btnTextWidth) ;
            _flagLine.frame = frameFlag;
        }
        
        NSInteger tag = button.tag -1;
        id<TQLSwitchViewItemProtocal> obj = self.arrayItem[tag];
        NSInteger offset = 0;
        if (obj && [obj respondsToSelector:@selector(itemImgAlinmgent)]) {
            TQLSwitchImgAlignment type = [obj itemImgAlinmgent];
            if (type == TQLSwitchImgAlignmentHorizontalLeft) {
                offset = [obj itemImgNormalSize].width/2;
            }else if (type == TQLSwitchImgAlignmentHorizontalRight) {
                offset = - [obj itemImgNormalSize].width/2;
            }
          
        }
     
        [UIView animateWithDuration:0.4 animations:^{
            if (button.titleLabel.textAlignment == NSTextAlignmentCenter) {
                self.flagLine.center = CGPointMake(button.center.x + offset,self.flagLine.center.y);
            }else if (button.titleLabel.textAlignment == NSTextAlignmentLeft) {
                self.flagLine.center = CGPointMake(button.center.x - self.switchViewStyle.scrollViewItemInterMargin/4 + offset,self.flagLine.center.y);
            }
            else{
                self.flagLine.center = CGPointMake(button.center.x + offset,self.flagLine.center.y);
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


