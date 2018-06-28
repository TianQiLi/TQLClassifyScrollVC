//
//  TQLCollectionViewCellBase.h
//  TQLClassifyScrollVC
//
//  Created by litianqi on 2018/6/27.
//

#import <UIKit/UIKit.h>
@interface TQLCollectionViewCellBase : UICollectionViewCell
@property (readonly)UICollectionView * subCollectionView;
@property (readonly)UITableView * tableView;
- (void)viewDidLoad;
- (void)viewWillAppear:(NSInteger)index;
@end
