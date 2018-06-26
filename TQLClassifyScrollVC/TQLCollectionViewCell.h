//
//  TQLCollectionViewCell.h
//  
//
//  Created by litianqi on 2017/9/5.
//  Copyright © 2017年 edu24ol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TQLClassifyScrollVC.h"
#import "TQLCollectionViewCell+DZNEmptyDataSet.h"
extern NSString * const SwitchBttonClickNotification;
extern NSString * const CellSelectedNotification;

@interface TQLCollectionViewCell : UICollectionViewCell<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate>
@property (readonly)UICollectionView * subCollectionView;
@property (readonly)UITableView * tableView;
/** para */
@property (nonatomic, strong) NSDictionary *paraDic;
/** id */
@property (nonatomic, weak) TQLClassifyScrollVC * currentVC;
@property (nonatomic, strong) NSMutableDictionary *dataForRowArray;
@property (nonatomic, strong) NSMutableDictionary *pageForIndex;
/** row */
@property (nonatomic, assign) NSInteger row;//in superCollection
@property (nonatomic, assign) NSInteger page;//1...n
@property (nonatomic, assign,readonly) NSInteger currentSwitchBtnIndex;//1...n
/** isSubCollectionType = yes ; no 表示是tableView */
//@property (nonatomic, assign) BOOL isSubCollectionType;//默认yes

- (void)setCurrentVC:(TQLClassifyScrollVC *)currentVC;

/*need override*/
- (void)viewDidLoad;
- (void)viewWillAppear;
- (BOOL)ignoreSwitchBtnEvent;
//建议重写：自定义
+ (NSString *)cellIdentifiter;

@end
