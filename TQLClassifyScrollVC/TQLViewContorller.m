//
//  TQLCollectionViewCell.m
//  
//
//  Created by litianqi on 2017/9/5.
//  Copyright © 2017年 edu24ol. All rights reserved.
//

#import "TQLViewContorller.h"
NSString * const CellSelectedNotification = @"CellSelectedNotification";

@interface TQLViewContorller(){
}

@end

@implementation TQLViewContorller
- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _pageForIndex = @{}.mutableCopy;
        _dataForRowArray = @{}.mutableCopy;
        _paraDic = @{}.mutableCopy;
        [self viewDidLoad];
    }
    return self;
}

- (void)setCurrentVC:(TQLClassifyScrollVC *)currentVC{
    _currentVC = currentVC;
}

- (void)setRow:(NSInteger)row{
    _row = row;
    [self viewWillAppear:_row];
}

- (NSInteger)currentSwitchBtnIndex{
    return _currentVC.currentSwitchBtnIndex;
}

+ (NSString *)cellIdentifiter{
    return  @"Nest_CollectionViewCellIdentif";
}

- (BOOL)ignoreSwitchBtnEvent{
    return NO;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    return [super hitTest:point withEvent:event];
}
// 解决左右滑动手势冲突问题-对右滑返回手势做了特定屏幕的兼容
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    if (CGRectContainsPoint(self.frame, point)) {
        if (point.x < 40 && point.x >= 0) {
            self.currentVC.collection.scrollEnabled = NO;
        }else
        self.currentVC.collection.scrollEnabled = YES;
    }
    return [super pointInside:point withEvent:event];
}
@end
