//
//  FreeCourseVC.m
//  Hq100yyApp
//
//  Created by litianqi on 2017/8/25.
//  Copyright © 2017年 edu24ol. All rights reserved.
//

#import "TQLClassifyScrollVC.h"
#import "TQLClassifyScrollVC_Header.h"
NSString * const SwitchBttonClickNotification = @"SwitchBttonClickNotification";
NSString * const TQLCS_ReceiveMemoryWarningNotification = @"TQLCS_ReceiveMemoryWarningNotification";

static NSInteger heightCollection = 0;
@interface TQLClassifyScrollVC ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,TQLSwitchViewToolDelegate,UIContentContainer>
@property (nonatomic, strong) UICollectionView * collection;
@property (nonatomic, strong) TQLSwitchViewTool * switchViewTool;
@property (nonatomic, strong) NSArray * arrayItem;
@property (nonatomic, strong) NSArray *  classCustomArray;
@property (nonatomic, strong) NSArray *cellIdentifiterArray;

@property (nonatomic, strong) NSMutableDictionary *dataForRowArray;
@property (nonatomic, strong) NSMutableDictionary *pageForIndex;
@property (nonatomic, assign) NSInteger bottomMargin;//button & cell : default:10


@property (nonatomic, assign) NSInteger currentSwitchBtnIndex;//1...n



/*selfBGStyle-option*/
/** font */
@property (nonatomic, strong) UIColor *viewBgColor;

/*option */
@property (nonatomic, strong) UIColor *switchViewBgColor;
/*option */
@property (nonatomic, strong) UIColor *collectionBGColor;
/*option */
@property (nonatomic, strong) UIColor * mjRefreshColor;
/** tap */
@property (nonatomic, strong) UITapGestureRecognizer *tagG;

#pragma mark  frame 处理
@property (nonatomic) CGRect orignalRect;
@property (nonatomic) CGSize flexCellSize;
/*page cell 上下的绝对间距*/
@property (nonatomic) CGFloat topAndBottomFixedForSlideCell;
/*page cell 左右的绝对间距*/
@property (nonatomic) CGFloat leftAndRightFixedForSlideCell;

/** viewdidload 是否执行过 */
@property (nonatomic, assign) BOOL viewMethodLoaded;

//滚动是点击触发，还是滑动触发
@property (nonatomic, assign) BOOL scrollFromClickEvent;

@end

@implementation TQLClassifyScrollVC

//+ (void)setNavAppearce:(UINavigationController *)nav isHidden:(BOOL)hidden{
//
//    if (hidden) {
//        [nav.navigationBar setShadowImage:[UIImagehq_imageWithColor:[UIColor colorWithHexString:@"ffffff"]]];
//    }else
//        [nav.navigationBar setShadowImage:[UIImagehq_imageWithColor:[UIColor colorWithHexString:@"efeff0"]]];
//}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_navBarShadowImageHidden) {
        [self.navigationController.navigationBar setShadowImage:_navBarShadowImageHidden];
    }
    if (self.viewWillAppearBlock) {
        self.viewWillAppearBlock();
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (_navBarShadowImageHidden) {
        [self.navigationController.navigationBar setShadowImage:_navBarShadowImageHidden];
    }
    if (self.viewDidAppearBlock) {
        self.viewDidAppearBlock();
    }
    
    //修正，其他页面的旋转
    if (self.enableRotate && self.flexCellSize.width > 0 && self.flexCellSize.width != self.collection.bounds.size.width) {
        CGFloat heightCell = MAX(0, TQLScreenBound().height - _topAndBottomFixedForSlideCell);
        _flexCellSize = CGSizeMake(self.collection.bounds.size.width, heightCell);
        [self.collection reloadData];
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (_navBarShadowImageShow) {
         [self.navigationController.navigationBar setShadowImage:_navBarShadowImageShow];
    }
    if (self.viewDidDisappearBlock) {
        self.viewDidDisappearBlock();
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.viewWillDisappearBlock) {
        self.viewWillDisappearBlock();
    }
}

- (void)dealloc{
    NSLog(@"%s",__func__);
    [_maskView removeGestureRecognizer:_tagG];
    _tagG = nil;
    if(self.blockForDealloc){
        self.blockForDealloc();
    }

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
        if (!_cellIdentifiterArray || _cellIdentifiterArray.count == 0) {
            NSMutableArray * array = @[].mutableCopy;
            NSString * cellDefaultIdentifiter = @"cellDefaultIdentifiter";
            for (NSInteger i = 0;i < arrayItem.count ; ++i) {
                [array addObject:[NSString stringWithFormat:@"%@_%ld",cellDefaultIdentifiter,(long)i]];
            }
            _cellIdentifiterArray = array.copy;
        }
        _bottomMargin = 10;//default
        _currentSwitchBtnIndex = 1;
        _enableScollForSwitchClick = NO;
        _enableRotate = NO;
        if (!CGRectIsEmpty(frame)) {
            _orignalRect = frame;
        }
        _memoryAutoClear = YES;
        
        _enableRotate = NO;
        _viewMethodLoaded = NO;
        
        if ([[self class] currentDeviceIsIpad_tq]) {
            _enableRotate = YES;
        }
    }
    return  self;
}

+ (BOOL)currentDeviceIsIpad_tq
{
    // 仅考虑iPhone/iPod或iPad
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return YES;
 
    } else {
        return NO;
    }
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

- (void)setOrignalRect:(CGRect)orignalRect{
    if (_viewMethodLoaded) {
        if (!CGRectIsEmpty(_orignalRect)) {
            self.view.frame = _orignalRect;
        }else{
            return;
        }
        _orignalRect = orignalRect;
        heightCollection = MAX(_orignalRect.size.height- self.switchViewStyle.switchViewHeight -_bottomMargin - self.switchViewStyle.switchViewY, 0);
        [self updateFixedMargin];
        [self.collection reloadData];
    }else{
        _orignalRect = orignalRect;
    }
}

- (void)updateFixedMargin
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    _topAndBottomFixedForSlideCell = screenSize.height- heightCollection;
    _leftAndRightFixedForSlideCell = screenSize.width - self.orignalRect.size.width;
    CGFloat width = MIN(self.orignalRect.size.width, [UIApplication sharedApplication].keyWindow.frame.size.width);
    _flexCellSize = CGSizeMake(width, heightCollection);
}


- (void)updateItemArray:(NSArray *)array
{
    NSInteger lastIndex = self.switchViewTool.currentIndex;
    _arrayItem = array;
    self.switchViewTool.arrayItem = array;
    [self.collection reloadData];
    if (lastIndex <= array.count) {
        self.switchViewTool.currentIndex = lastIndex;
    }
}

- (TQLSwitchViewTool *)switchViewTool{
    if (!_switchViewTool) {
        _switchViewTool = [[TQLSwitchViewTool alloc] initWithFrame:CGRectMake(0, self.switchViewStyle.switchViewY, self.view.frame.size.width,self.switchViewStyle.switchViewHeight)switchViewStyle:self.switchViewStyle];
        _switchViewTool.enumerateItemBtnBlock = self.enumerateItemBtnBlock;
        [self.view addSubview:_switchViewTool];
    }
    return _switchViewTool;
}

- (void)clickTapG:(UITapGestureRecognizer *)tagG{
    [self removeFromSuperViewWithAnimation:nil];
}

- (void)removeFromSuperViewWithAnimation:(void(^)())block{
    [UIView animateWithDuration:0.3 animations:^{
        self.switchViewTool.transform = CGAffineTransformMakeTranslation(0, self.view.frame.size.height);
        self.collection.transform = self.switchViewTool.transform;
    } completion:^(BOOL finished) {
        self.switchViewTool.transform = CGAffineTransformIdentity;
        self.collection.transform = CGAffineTransformIdentity;
        [self removeFromParentViewController];
        [self.view removeFromSuperview];
        [self didMoveToParentViewController:nil];
        if (block) {
            block();
        }
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.maskView.alpha = 0.4;
    }];
}

- (void)showViewWithAnimation:(void(^)())block{
    self.switchViewTool.transform = CGAffineTransformMakeTranslation(0, self.view.frame.size.height);
    self.collection.transform = self.switchViewTool.transform;
    [UIView animateWithDuration:0.3 animations:^{
        self.switchViewTool.transform = CGAffineTransformIdentity;
        self.collection.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        if (block) {
            block();
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     _viewMethodLoaded = YES;
    if (!CGRectIsEmpty(_orignalRect)) {
        self.view.frame = _orignalRect;
    }else{
        _orignalRect = self.view.frame;
    }
    
    heightCollection = MAX(self.view.frame.size.height- self.switchViewStyle.switchViewHeight -_bottomMargin - self.switchViewStyle.switchViewY ,0);
    [self updateFixedMargin];
    
     UIColor * colorWhite = [TQLCollectionViewCellBase tq_WhiteColor:[UIColor whiteColor]];
    if (self.switchViewStyle.switchViewY > 0) {
        _maskView = [[UIView alloc] initWithFrame:self.view.bounds];
        [_maskView setBackgroundColor:colorWhite];
        [self.view addSubview:_maskView];
        _tagG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTapG:)];
        [_maskView addGestureRecognizer:_tagG];
        
        [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.view);
            make.trailing.equalTo(self.view);
            make.top.equalTo(self.view);
            make.bottom.equalTo(self.view);
        }];
    }
    
    if (self.viewBgColor) {
         UIColor * color = [TQLCollectionViewCellBase tq_ViewBgColor:self.viewBgColor];
         [_maskView setBackgroundColor:color];
         [self.view setBackgroundColor:color];
    }else{
        [self.view setBackgroundColor:colorWhite];
    }
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _dataForRowArray = [NSMutableDictionary new];
    _pageForIndex = [NSMutableDictionary new];
    
    self.switchViewTool.arrayItem = _arrayItem;
    self.switchViewTool.delegate = self;
    if (self.switchViewBgColor) {
        UIColor * color = [TQLCollectionViewCellBase tq_WhiteColor:self.switchViewBgColor];
        [_switchViewTool setBackgroundColor:color];
    }else{
        [_switchViewTool setBackgroundColor:colorWhite];
    }
       
    [self.view addSubview:_switchViewTool];
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [flowLayout setMinimumInteritemSpacing:0.0f];
    [flowLayout setMinimumLineSpacing:0.0f];
    [flowLayout setSectionInset:UIEdgeInsetsZero];

    _collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, heightCollection) collectionViewLayout:flowLayout];
    _collection.pagingEnabled = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0,*)) {
        self.collection.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
 
    _collection.delegate = self;
    _collection.dataSource = self;
    _collection.pagingEnabled = YES;
    _collection.showsVerticalScrollIndicator = NO;
    if (self.collectionBGColor) {
        UIColor * color = [TQLCollectionViewCellBase tq_CellBgColor:self.collectionBGColor];
        [_collection setBackgroundColor:color];
    }else{
        [_collection setBackgroundColor:colorWhite];
    }
    
    [self.view addSubview:_collection];
  
    NSInteger max_count = MAX(self.classCustomArray.count, self.cellIdentifiterArray.count);
    for (NSInteger i = 0 ; i< max_count ; i++) {
        NSString * classCustom = (self.classCustomArray.count > i) ?self.classCustomArray[i] : self.classCustomArray.lastObject;
        NSString * cellIdentif = (self.cellIdentifiterArray.count > i) ?self.cellIdentifiterArray[i] : self.cellIdentifiterArray.lastObject;
        [self.collection registerClass:NSClassFromString(classCustom) forCellWithReuseIdentifier:cellIdentif];
    }
    
    [_switchViewTool mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
        make.top.equalTo(self.view).offset(self.switchViewStyle.switchViewY);
        make.height.equalTo(@(self.switchViewStyle.switchViewHeight));
    }];
    
    [_collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
        make.top.equalTo(self.switchViewTool.mas_bottom).offset(self.bottomMargin);
        make.bottom.equalTo(self.view);
    }];

    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reLayoutCollectionView:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    if (_currentSwitchBtnIndex > 1) {
        self.switchViewTool.currentIndex = self.currentSwitchBtnIndex;
        [self clickButton:_switchViewTool.currentIndex];
    }
    
    if (self.viewDidLoadBlock) {
        self.viewDidLoadBlock();
    }
   
}

-(void)reLayoutCollectionView:(NSNotification *)notification {
//    if (_enableRotate) {
//        [self updateFlexiableCellSizeForRotate];
//    }
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator API_AVAILABLE(ios(8.0))
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    if (self.enableRotate) {
        CGFloat _offsetX = size.width * (_currentSwitchBtnIndex - 1);
        _offsetX = MAX(0, _offsetX);
        _offsetX = MIN(_collection.contentSize.width, _offsetX);
        CGFloat _offsetY = _collection.contentOffset.y;
        self.collection.contentOffset = CGPointMake(_offsetX, _offsetY);
        
        CGFloat heightCell = MAX(0, TQLScreenBound().height - _topAndBottomFixedForSlideCell);
        _flexCellSize = CGSizeMake(size.width, heightCell);
        [self.collection reloadData];
    }
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _arrayItem.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return _flexCellSize;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellIdentifiter = @"";
    if (indexPath.row < self.cellIdentifiterArray.count) {
         cellIdentifiter = self.cellIdentifiterArray[indexPath.row];
    }else{
        cellIdentifiter = (self.cellIdentifiterArray.count > 0) ? self.cellIdentifiterArray.lastObject : @"cell";
    }
//    NSLog(@"cellForItem=%ld\n",indexPath.row);
    TQLViewContorller * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifiter forIndexPath:indexPath];
    cell.currentVC = self;
    cell.configTQLVCBlock = self.configTQLVCBlock;
    [cell cellForItem:indexPath.row];
    cell.mjRefreshColor = self.mjRefreshColor;
    cell.paraDic = self.paramaterDic;
    cell.dataForRowArray = self.dataForRowArray;
    cell.pageForIndex = self.pageForIndex;
    cell.switchToolBtnArray = self.switchViewTool.btnArray;
    cell.switchToolItemArray = self.switchViewTool.arrayItem;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
//     NSLog(@"willDisplay=%ld\n",indexPath.row);
    TQLViewContorller * cellNew = (TQLViewContorller *)cell;
    [cellNew willDisplayRow:indexPath.row];
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    TQLViewContorller * cellNew = (TQLViewContorller *)cell;
    [cellNew didEndDisplayRow:indexPath.row];
   
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
     _scrollFromClickEvent = NO;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    CGPoint point  = *targetContentOffset;
    NSIndexPath * indexPath = [self.collection indexPathForItemAtPoint:point];
//    DDlogInfo(@"scrollView row =%ld",indexPath.row);
    NSInteger row = indexPath.row;
    if (!indexPath) {
        row = point.x/scrollView.frame.size.width;
    }
    _scrollFromClickEvent = NO;
    _currentSwitchBtnIndex = row + 1;
    self.switchViewTool.currentIndex = _currentSwitchBtnIndex;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.dragging || scrollView.tracking || scrollView.decelerating) {
        return;
    }
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(scrollViewDidEndScrollingAnimation:) withObject:scrollView afterDelay:0.3];
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    CGFloat offSet = scrollView.contentOffset.x;
    CGFloat offsetNew = MAX((_currentSwitchBtnIndex-1), 0)*self.view.frame.size.width;
    if (offsetNew != offSet ) {
        scrollView.contentOffset = CGPointMake(offsetNew, 0);
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"%s",__func__);
    [[NSNotificationCenter defaultCenter] postNotificationName:TQLCS_ReceiveMemoryWarningNotification object:nil];
}

#pragma mark --TQLSwitchViewToolDelegate
- (void)clickButton:(NSInteger)index{
    TQLViewContorller * cell = (TQLViewContorller *)[self.collection cellForItemAtIndexPath:[NSIndexPath indexPathForRow:(_currentSwitchBtnIndex - 1) inSection:0]];
    _scrollFromClickEvent = YES;
    if (self.ClickItemEventBlock) {
        self.ClickItemEventBlock(index,_currentSwitchBtnIndex);
    }
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
            
            UICollectionViewLayoutAttributes *attributes = [_collection layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:row_now inSection:0]];
            [_collection setContentOffset:attributes.frame.origin animated:NO];///fix:ios 14 不会滚动问题
//            [_collection scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:row_now inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        }
  
    }
   
    UICollectionViewLayoutAttributes *attributes = [_collection layoutAttributesForItemAtIndexPath:indexPathTo];
        [_collection setContentOffset:attributes.frame.origin animated:_enableScollForSwitchClick];///fix:ios 14 不会滚动问题
    
//    [_collection scrollToItemAtIndexPath:indexPathTo atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:_enableScollForSwitchClick];///ios 14有问题，不会滚动
    [[NSNotificationCenter defaultCenter] postNotificationName:SwitchBttonClickNotification object:@(_currentSwitchBtnIndex)];
}

- (void)setMJRefreshBgColor:(UIColor *)mjRefreshColor{
    _mjRefreshColor = mjRefreshColor;
}

- (void)reloadSpecialCellReload:(NSInteger)row{
    TQLViewContorller * cell = (TQLViewContorller *)[self.collection cellForItemAtIndexPath:[NSIndexPath indexPathForItem:row inSection:0]];
    if([cell isKindOfClass:[TQLViewContorller class]]){
        [cell willDisplayRow:row];
    }
}

- (void)reload{
    [self.collection reloadData];
}

- (void)removeAllData{
    [self.dataForRowArray removeAllObjects];
}

- (void)staticsCourseType:(NSInteger)index{
    
}

- (void)setCurrentSwitchButtonIndex:(NSInteger)switchBtnIndex isDefault:(BOOL)isDefault{
    self.currentSwitchBtnIndex = switchBtnIndex;
    if (!isDefault) {
        self.switchViewTool.currentIndex = switchBtnIndex;
        [self clickButton:_switchViewTool.currentIndex];
    }
 
}

- (BOOL)scrollFromClickEvent
{
    return _scrollFromClickEvent;
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


