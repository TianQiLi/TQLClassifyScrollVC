//
//  TQLCollectionViewCellBase.m
//  TQLClassifyScrollVC
//
//  Created by litianqi on 2018/6/27.
//

#import "TQLCollectionViewCellBase.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import <Masonry/Masonry.h>
@interface TQLCollectionViewCellBase()<DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>{
    UICollectionView * _subCollectionView;
    UITableView * _tableView;
}
@end
@implementation TQLCollectionViewCellBase

- (UICollectionView *)subCollectionView
{
    if (!_subCollectionView) {
        
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setMinimumInteritemSpacing:0.0f];
        [flowLayout setMinimumLineSpacing:0.0f];
        [flowLayout setSectionInset:UIEdgeInsetsZero];
        
        _subCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 300) collectionViewLayout:flowLayout];
        [_subCollectionView setBackgroundColor:[UIColor whiteColor]];
        _subCollectionView.delegate = self;
        _subCollectionView.dataSource = self;
        if (@available(iOS 11.0, *)) {
            _subCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _subCollectionView.emptyDataSetSource = self;
        _subCollectionView.emptyDataSetDelegate = self;
        [self.contentView addSubview:_subCollectionView];
        [_subCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.contentView);
            make.trailing.equalTo(self.contentView);
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
        }];
        _currentScrollView = _subCollectionView;
    }
    return _subCollectionView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 10, 10) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
        
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            NSInteger bottom = self.safeAreaInsets.bottom ? self.safeAreaInsets.bottom : 40;
            _tableView.contentInset = UIEdgeInsetsMake(0, 0, bottom, 0);
        }
        
        if (@available(iOS 15.0 ,*)) {
            _tableView.sectionHeaderTopPadding = 0;
            if (_tableView.style == UITableViewStyleGrouped) {
                _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, CGFLOAT_MIN)];
            }
        }
         
        [self.contentView addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.contentView);
            make.trailing.equalTo(self.contentView);
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
        }];
         _currentScrollView = _tableView;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (BOOL)isTableViewContoller
{
    if (_tableView) {
        return YES;
    }
    return NO;
}

- (BOOL)isCollectionViewContoller
{
    if (_subCollectionView) {
        return YES;
    }
    
    return NO;
}

- (void)viewDidLoad
{
    
}

- (void)viewWillAppear:(NSInteger)index
{
    
}
- (void)viewDidDisappear:(NSInteger)index
{
    
}

- (NSArray *)tq_ignoreKeyArray
{
    return nil;
}

- (NSArray *)tq_needCacheKeyArray
{
    return nil;
}

+ (NSString *)cachePageClassStr
{
    return NSStringFromClass(TQLPageDataCache.class);
}

+ (NSString *)autocachePageClassStr
{
    return NSStringFromClass(TQLPageDataAutoCache.class);
}


@end
