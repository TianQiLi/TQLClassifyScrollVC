//
//  SwitchViewButton.h
//  hqedu24olapp
//
//  Created by litianqi on 16/7/21.
//  Copyright © 2016年 edu24ol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TQLRedBadgeBttton.h"
#import "TQLSwitchViewStyleModel.h"
typedef void(^EnumerateItemBtnBlock)(TQLRedBadgeBttton * itemBtn,NSInteger index);//index:1...n



//@class TQLSwitchViewStyleModel;

@protocol TQLSwitchViewToolDelegate <NSObject>
- (void)clickButton:(NSInteger)index;//1...n
- (void)configStyle:(TQLRedBadgeBttton *)itemBtn;//1...n
@end

@interface TQLSwitchViewTool : UIView
@property (nonatomic, copy)NSArray<id<TQLSwitchViewItemProtocal>> *arrayItem;
@property (nonatomic, assign)NSInteger currentIndex;//默认1: 1...n
@property (nonatomic, weak) id<TQLSwitchViewToolDelegate>delegate;
/** 是否需要圆角 */
@property (nonatomic, assign) float cornerRadius;

/** arrayBtn */
@property (nonatomic, copy) NSArray *btnArray;
/** 遍历分类button */
@property (nonatomic, copy) EnumerateItemBtnBlock enumerateItemBtnBlock;

- (id)initWithFrame:(CGRect)frame switchViewStyle:(TQLSwitchViewStyleModel *)switchViewStyle;
/** TQLSwitchViewStyleModel */
@property (nonatomic, readonly) TQLSwitchViewStyleModel *switchViewStyle;

/// 加载指示器样式UI 
- (void)loadCustomIndicatorView;

+ (CGSize)contentSize;
- (void)setSwitchViewStyle:(TQLSwitchViewStyleModel *)switchViewStyle;
- (UIView *)flagView;
- (void)clickButton:(id)sender;

/// 滚动到指定的index
/// - Parameter index: 1...n
- (void)scrollToIndex:(NSInteger)index;

- (void)updateButtonFrameAfterRotate;


/// 更新指示器模式下的个数
/// - Parameter count: 个数
- (void)updateViewForCount:(NSInteger)count;
@end



//@interface TQLSwitchViewButtonCollectionCell : UICollectionViewCell<TQLSwitchViewToolDelegate>
//@property (nonatomic, strong) TQLSwitchViewTool * swithchViewTool;
//@property (nonatomic, weak) id<TQLSwitchViewToolDelegate> delegate;
//
//@end
//
//
//@interface TQLSwitchViewButtonCollectionReusableViewCell : UICollectionReusableView<TQLSwitchViewToolDelegate>
//@property (nonatomic, strong) TQLSwitchViewTool * swithchViewTool;
//@property (nonatomic, weak) id<TQLSwitchViewToolDelegate> delegate;
//@property (nonatomic, assign) NSInteger currentIndex;
//
//
//@end
