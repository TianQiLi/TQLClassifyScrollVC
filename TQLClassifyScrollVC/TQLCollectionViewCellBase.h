//
//  TQLCollectionViewCellBase.h
//  TQLClassifyScrollVC
//
//  Created by litianqi on 2018/6/27.
//

#import <UIKit/UIKit.h>

#import "TQLDataCacheManager.h"
typedef void(^SuccessBlock)(NSArray * array);
typedef void(^FailureBlock)(NSError * error);

@interface TQLCollectionViewCellBase : UICollectionViewCell<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>
@property (readonly)UICollectionView * subCollectionView;
@property (readonly)UITableView * tableView;
@property (strong,atomic)TQLPageDataCache * pageDataCahe;
@property (strong,atomic)TQLPageDataCache * pageDataAutoCahe;
/** scrollView */
@property (nonatomic, readonly) UIScrollView *currentScrollView;
- (BOOL)isTableViewContoller;
- (BOOL)isCollectionViewContoller;
- (void)viewDidLoad;
/*指定忽略缓存的成员：例：@[@"_xxx"]*/
- (NSArray *)tq_ignoreKeyArray;
/*指定需要缓存的成员：例：@[@"_xxx"]*/
- (NSArray *)tq_needCacheKeyArray;
/**
 index = 0...n
 */
- (void)viewWillAppear:(NSInteger)index;
- (void)viewDidDisappear:(NSInteger)index;
//子类可以重写，默认TQLPageDataCache
+ (NSString *)cachePageClassStr;
//子类可重写，不过不建议重写，应该用不到
+ (NSString *)autocachePageClassStr;
@end
