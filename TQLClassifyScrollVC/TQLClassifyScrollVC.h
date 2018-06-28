//

//
//
//  Created by litianqi on 2017/8/25.
//  Copyright © 2017年 edu24ol. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TQLSwitchViewStyleModel;
@class TQLSwitchViewButton;
extern NSString * const SwitchBttonClickNotification;

@interface TQLClassifyScrollVC : UIViewController
@property (nonatomic, readonly) UICollectionView * collection;
@property (nonatomic, readonly) TQLSwitchViewButton * switchViewButton;

/**clollection scroll by SwitchClick NO */
@property (nonatomic, assign) BOOL enableScollForSwitchClick;
/**when enableScollForSwitchClick = yes, justTwoScrollForSwitchClick is yes ,animation happen in two cell ;else hapen more cell */
@property (nonatomic, assign) BOOL justTwoScrollForSwitchClick;

/** TQLSwitchViewStyleModel */
@property (nonatomic, strong) TQLSwitchViewStyleModel *switchViewStyle;
/** paramater */
@property (nonatomic, strong) NSDictionary *paramaterDic;
- (id)initWithSwitchItemArray:(NSArray<NSString *> *)arrayItem withClassArray:(NSArray<NSString *> *)classCellArray withIdentifiter:(NSArray<NSString *> *)cellIdentiArray;
- (id)initWithSwitchItemArray:(NSArray<NSString *> *)arrayItem withClassArray:(NSArray<NSString *> *)classCellArray withIdentifiter:(NSArray<NSString *> *)cellIdentiArray  withRect:(CGRect)frame;

 /*配置子视图bg color*/
- (void)configViewBgColor:(UIColor *)bgColor collectionBGColor:(UIColor *)colorCollectionBG swithBtnViewBGColor:(UIColor *)colorBGSwitchBtn;
- (void)setSwitchButtonBottomMargin:(NSInteger)bottomMargin;
- (void)staticsCourseType:(NSInteger)index;

- (void)setCurrentSwitchButtonIndex:(NSInteger)switchBtnIndex;
- (NSInteger)currentSwitchBtnIndex;
@end
