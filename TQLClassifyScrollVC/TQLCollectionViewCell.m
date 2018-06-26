//
//  TQLCollectionViewCell.m
//  
//
//  Created by litianqi on 2017/9/5.
//  Copyright © 2017年 edu24ol. All rights reserved.
//

#import "TQLCollectionViewCell.h"
#import "TQLClassifyScrollVCHeader.h"
NSString * const CellSelectedNotification = @"CellSelectedNotification";

@interface TQLCollectionViewCell()<DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>{
    UICollectionView * _subCollectionView;
    UITableView * _tableView;
}

@end

@implementation TQLCollectionViewCell


- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _pageForIndex = @{}.mutableCopy;
        _dataForRowArray = @{}.mutableCopy;
        _paraDic = @{}.mutableCopy;
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setMinimumInteritemSpacing:0.0f];
        [flowLayout setMinimumLineSpacing:0.0f];
        [flowLayout setSectionInset:UIEdgeInsetsZero];
        [self viewDidLoad];
    }
    return self;
}

- (UICollectionView *)subCollectionView{
    if (!_subCollectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setMinimumInteritemSpacing:0.0f];
        [flowLayout setMinimumLineSpacing:0.0f];
        [flowLayout setSectionInset:UIEdgeInsetsZero];
        
        _subCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 300) collectionViewLayout:flowLayout];
        [_subCollectionView setBackgroundColor:[UIColor whiteColor]];
        _subCollectionView.delegate = self;
        _subCollectionView.dataSource = self;
        _subCollectionView.emptyDataSetSource = self;
        _subCollectionView.emptyDataSetDelegate = self;
        [self.contentView addSubview:_subCollectionView];
        [_subCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.contentView);
            make.trailing.equalTo(self.contentView);
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
        }];
    }
    return _subCollectionView;
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 10, 10) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        [self.contentView addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.contentView);
            make.trailing.equalTo(self.contentView);
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
        }];
    }
    return _tableView;
}

- (void)setCurrentVC:(TQLClassifyScrollVC *)currentVC{
    _currentVC = currentVC;
}

- (void)setRow:(NSInteger)row{
    _row = row;
    [self viewWillAppear:_row];
}

- (void)viewDidLoad{
    
}

- (void)viewWillAppear:(NSInteger)index{
    
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
