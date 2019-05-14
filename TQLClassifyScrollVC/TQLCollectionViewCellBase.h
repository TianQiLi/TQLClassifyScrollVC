//
//  TQLCollectionViewCellBase.h
//  TQLClassifyScrollVC
//
//  Created by litianqi on 2018/6/27.
//

#import <UIKit/UIKit.h>


typedef void(^SuccessBlock)(NSArray * array);
typedef void(^FailureBlock)(NSError * error);

@interface TQLCollectionViewCellBase : UICollectionViewCell<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>
@property (readonly)UICollectionView * subCollectionView;
@property (readonly)UITableView * tableView;
/** scrollView */
@property (nonatomic, readonly) UIScrollView *currentScrollView;
- (BOOL)isTableViewContoller;
- (BOOL)isCollectionViewContoller;
- (void)viewDidLoad;
/**
 index = 0...n
 */
- (void)viewWillAppear:(NSInteger)index;
- (void)viewDidDisappear:(NSInteger)index;
@end
