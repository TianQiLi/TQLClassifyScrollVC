//
//  FreeCourseVC.m
//  Hq100yyApp
//
//  Created by litianqi on 2017/8/25.
//  Copyright © 2017年 edu24ol. All rights reserved.
//

#import "TQLClassifyScrollVC.h"
#import "TQLClassifyScrollVCHeader.h"

NSString * const SwitchBttonClickNotification = @"SwitchBttonClickNotification";
@interface TQLClassifyScrollVC ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,TQLSwitchViewButtonDelegate>
@property (nonatomic, strong) UICollectionView * collection;
@property (nonatomic, strong) TQLSwitchViewButton * switchViewButton;
@property (nonatomic, strong) NSArray * arrayItem;
@property (nonatomic, strong) NSArray *  classCustomArray;
@property (nonatomic, strong) NSArray *cellIdentifiterArray;

@property (nonatomic, strong) NSMutableDictionary *dataForRowArray;
@property (nonatomic, strong) NSMutableDictionary *pageForIndex;
@property (nonatomic, assign) NSInteger bottomMargin;//button & cell : default:10


@property (nonatomic, assign) NSInteger currentSwitchBtnIndex;//1...n
@property (nonatomic) CGRect orignalRect;


/*selfBGStyle-option*/
/** font */
@property (nonatomic, strong) UIColor *viewBgColor;

/*option */
@property (nonatomic, strong) UIColor *switchViewBgColor;
/*option */
@property (nonatomic, strong) UIColor *collectionBGColor;

@end

@implementation TQLClassifyScrollVC

- (void)dealloc{
    NSLog(@"%s",__func__);
}

- (UICollectionView *)collection{
    return _collection;
}

- (NSInteger)currentSwitchBtnIndex{
    return _currentSwitchBtnIndex;
}

- (void)configViewBgColor:(UIColor *)bgColor collectionBGColor:(UIColor *)colorCollectionBG swithBtnViewBGColor:(UIColor *)colorBGSwitchBtn{
    _viewBgColor = bgColor;
    _collectionBGColor = colorCollectionBG;
    _switchViewBgColor = colorBGSwitchBtn;
    
}

- (id)initWithSwitchItemArray:(NSArray<NSString *> *)arrayItem withClassArray:(NSArray<NSString *> *)classCellArray withIdentifiter:(NSArray<NSString *> *)cellIdentiArray{
    return [self initWithSwitchItemArray:arrayItem withClassArray:classCellArray withIdentifiter:cellIdentiArray withRect:CGRectNull];
}

- (id)initWithSwitchItemArray:(NSArray<NSString *> *)arrayItem withClassArray:(NSArray<NSString *> *)classCellArray withIdentifiter:(NSArray<NSString *> *)cellIdentiArray  withRect:(CGRect)frame {
    if (self = [super init]) {
        _arrayItem = arrayItem;
        _classCustomArray = classCellArray;
        _cellIdentifiterArray = cellIdentiArray;
        _bottomMargin = 10;//default
        _currentSwitchBtnIndex = 1;
        _orignalRect = frame;
        _enableScollForSwitchClick = NO;
    }
    return  self;
}

- (TQLSwitchViewStyleModel *)switchViewStyle{
    if (!_switchViewStyle) {
        _switchViewStyle = [[TQLSwitchViewStyleModel alloc] init];
    }
    return _switchViewStyle;
}

- (void)setSwitchButtonBottomMargin:(NSInteger)bottomMargin{
    _bottomMargin = bottomMargin;
}

- (TQLSwitchViewButton *)switchViewButton{
    if (!_switchViewButton) {
        _switchViewButton = [[TQLSwitchViewButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.switchViewStyle.switchViewHeight)switchViewStyle:self.switchViewStyle];
    
    }
    return _switchViewButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.viewBgColor) {
        [self.view setBackgroundColor:self.viewBgColor];
    }else
        [self.view setBackgroundColor:[UIColor whiteColor]];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _dataForRowArray = [NSMutableDictionary new];
    _pageForIndex = [NSMutableDictionary new];
    
    self.switchViewButton.arrayItem = _arrayItem;
    self.switchViewButton.delegate = self;
    if (self.switchViewBgColor) {
        [_switchViewButton setBackgroundColor:self.switchViewBgColor];
    }else
        [_switchViewButton setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_switchViewButton];
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [flowLayout setMinimumInteritemSpacing:0.0f];
    [flowLayout setMinimumLineSpacing:0.0f];
    [flowLayout setSectionInset:UIEdgeInsetsZero];

    _collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
    if (@available(iOS 11.0,*)) {
        self.collection.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
 
    _collection.delegate = self;
    _collection.dataSource = self;
    _collection.pagingEnabled = YES;
    _collection.showsVerticalScrollIndicator = NO;
    if (self.collectionBGColor) {
         [_collection setBackgroundColor:self.collectionBGColor];
    }else
        [_collection setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_collection];
  
    for (NSInteger i = 0 ; i< self.arrayItem.count ; i++) {
        if (i >= self.classCustomArray.count) {
            continue;
        }
        NSString * classCustom = self.classCustomArray[i];
        NSString * cellIdentif = self.cellIdentifiterArray[i];
        [self.collection registerClass:NSClassFromString(classCustom) forCellWithReuseIdentifier:cellIdentif];
    }
    
    [_switchViewButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
        make.top.equalTo(self.view).offset(0);
        make.height.equalTo(@(self.switchViewStyle.switchViewHeight));
    }];
    
    [_collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
        make.top.equalTo(self.switchViewButton.mas_bottom).offset(_bottomMargin);
        make.bottom.equalTo(self.view);
    }];
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    
    
//     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reLayoutCollectionView:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

-(void)reLayoutCollectionView:(NSNotification *)notification {
//    _collection. itemSize = CGSizeMake(self.collection.bounds.size.width, self.collection.bounds.size.height);
//    [self.collection reloadData];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _arrayItem.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_orignalRect.size.height) {
        return CGSizeMake(_orignalRect.size.width, _orignalRect.size.height- self.switchViewStyle.switchViewHeight -_bottomMargin);
    }
    return CGSizeMake(self.view.frame.size.width, _collection.frame.size.height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellIdentifiter = @"";
    if (indexPath.row < self.cellIdentifiterArray.count) {
         cellIdentifiter = self.cellIdentifiterArray[indexPath.row];
    }else{
        cellIdentifiter = (self.cellIdentifiterArray.count >0) ? self.cellIdentifiterArray.lastObject : @"cell";
    }
   
    TQLCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifiter forIndexPath:indexPath];
    cell.currentVC = self;
    cell.paraDic = self.paramaterDic;
    cell.row = indexPath.row;//override
   
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
//    DDLogInfo(@"testrow=%ld\n",indexPath.row);
    TQLCollectionViewCell * cellNew = (TQLCollectionViewCell *)cell;
    NSNumber * page = self.pageForIndex[@(indexPath.row)];
    cellNew.page = page? [page integerValue] : 1;
    cellNew.pageForIndex = self.pageForIndex;
    cellNew.dataForRowArray = self.dataForRowArray;
    cellNew.row = indexPath.row;//override
    

}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    CGPoint point  = *targetContentOffset;
    NSIndexPath * indexPath = [self.collection indexPathForItemAtPoint:point];
//    DDlogInfo(@"scrollView row =%ld",indexPath.row);
    NSInteger row = indexPath.row;
    if (!indexPath) {
        row = point.x/scrollView.frame.size.width;
    }
    _currentSwitchBtnIndex = row + 1;
    self.switchViewButton.currentIndex = _currentSwitchBtnIndex;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --SwitchBttonDelegate
- (void)clickButton:(NSInteger)index{
    TQLCollectionViewCell * cell = (TQLCollectionViewCell *)[self.collection cellForItemAtIndexPath:[NSIndexPath indexPathForRow:(_currentSwitchBtnIndex - 1) inSection:0]];
    if ([cell ignoreSwitchBtnEvent]) {
        return;
    }

    _currentSwitchBtnIndex = index;
    [self staticsCourseType:index];
    NSInteger row_to = index - 1;
    
    NSIndexPath * indexPathTo = [NSIndexPath indexPathForRow:row_to inSection:0];
    NSArray<NSIndexPath *> * array = _collection.indexPathsForVisibleItems;
    
    if (!array || array.count == 0) {
        [_collection scrollToItemAtIndexPath:indexPathTo atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        return;
    }
    NSIndexPath * indexPath = array.firstObject;
    NSInteger row_now = indexPath.row;
    if (labs(row_to - row_now) >= 2) {
        if ((row_to - row_now) > 0) {
            row_now = row_to;
            row_now--;
        }
        else{
            row_now = row_to;
            row_now++;
        }
        if (self.enableScollForSwitchClick && self.justTwoScrollForSwitchClick) {
            [_collection scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:row_now inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        }
  
    }
    [_collection scrollToItemAtIndexPath:indexPathTo atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:_enableScollForSwitchClick];
    [[NSNotificationCenter defaultCenter] postNotificationName:SwitchBttonClickNotification object:@(_currentSwitchBtnIndex)];
}


- (void)staticsCourseType:(NSInteger)index{
    
}

- (void)setCurrentSwitchButtonIndex:(NSInteger)switchBtnIndex{
    _switchViewButton.currentIndex = switchBtnIndex;
    [self clickButton:_switchViewButton.currentIndex];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
