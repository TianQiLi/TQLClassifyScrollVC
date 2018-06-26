//
//  SwitchViewButton.h
//  hqedu24olapp
//
//  Created by litianqi on 16/7/21.
//  Copyright © 2016年 edu24ol. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TQLSwitchViewStyleModel;

@protocol TQLSwitchViewButtonDelegate <NSObject>
- (void)clickButton:(NSInteger)index;//1...n
@end

@interface TQLSwitchViewButton : UIView
@property (nonatomic, strong)NSArray * arrayItem;
@property (nonatomic, assign)NSInteger currentIndex;//默认1: 1...n
@property (weak ,nonatomic) id<TQLSwitchViewButtonDelegate>delegate;

-(id)initWithFrame:(CGRect)frame switchViewStyle:(TQLSwitchViewStyleModel *)switchViewStyle;
/** TQLSwitchViewStyleModel */
@property (nonatomic,readonly) TQLSwitchViewStyleModel *switchViewStyle;

+ (CGSize)contentSize;
- (void)setSwitchViewStyle:(TQLSwitchViewStyleModel *)switchViewStyle;

@end



@interface TQLSwitchViewButtonCollectionCell : UICollectionViewCell<TQLSwitchViewButtonDelegate>
@property (nonatomic, strong) TQLSwitchViewButton * swithchViewbutton;
@property (nonatomic, weak) id<TQLSwitchViewButtonDelegate> delegate;

@end


@interface TQLSwitchViewButtonCollectionReusableViewCell : UICollectionReusableView<TQLSwitchViewButtonDelegate>
@property (nonatomic, strong) TQLSwitchViewButton * swithchViewbutton;
@property (nonatomic, weak) id<TQLSwitchViewButtonDelegate> delegate;
@property (nonatomic, assign) NSInteger currentIndex;


@end
