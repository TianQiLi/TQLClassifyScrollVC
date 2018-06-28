//
//  TQLCollectionViewCellBase.m
//  TQLClassifyScrollVC
//
//  Created by litianqi on 2018/6/27.
//

#import "TQLCollectionViewCellBase.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import <Masonry/Masonry.h>
@interface TQLCollectionViewCellBase()<DZNEmptyDataSetDelegate,DZNEmptyDataSetSource,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>{
    UICollectionView * _subCollectionView;
    UITableView * _tableView;
}
@end
@implementation TQLCollectionViewCellBase

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

- (void)viewDidLoad{
    
}

- (void)viewWillAppear:(NSInteger)index{
    
}


@end
