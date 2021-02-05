//
//  TQLCollectionViewCell.m
//
//
//  Created by litianqi on 2017/9/5.
//  Copyright © 2017年 edu24ol. All rights reserved.
//

#import "TQLViewContorller.h"
#import "MJRefresh.h"
NSString * const CellSelectedNotification = @"CellSelectedNotification";

@interface TQLViewContorller(){
}


@end

@implementation TQLViewContorller
- (void)dealloc{
    NSLog(@"%s",__func__);
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TQLCS_ReceiveMemoryWarningNotification object:nil];
}

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _pageRows = 20;
        _page = 0;
        _pageFirst = 0;
        _enableHeaderRefresh = NO;
        _enableFooterRefresh = NO;
        _arrayData = @[];
        [self viewDidLoad];
    }
    return self;
}

- (void)cellForItem:(NSInteger)row{
    //清楚已有View
    _row = row;
    self.arrayData = @[];
    if (self.isTableViewContoller) {
        [self.tableView reloadData];
    }else  if (self.isCollectionViewContoller) {
        [self.subCollectionView reloadData];
    }
    
}

- (void)didEndDisplayRow:(NSInteger)row{
     _row = row;
     [self viewDidDisappear:_row];
}

- (void)willDisplayRow:(NSInteger)row{
    //赋值row
    _row = row;
    if (self.configTQLVCBlock) {
        self.configTQLVCBlock(self, row,nil);
    }
    if (_mjRefreshColor) {
        self.currentScrollView.mj_header.backgroundColor = self.mjRefreshColor;
        self.currentScrollView.mj_footer.backgroundColor = self.mjRefreshColor;
    }
    //赋值page
    NSNumber * page = self.pageForIndex[@(row)];
    _page = page? [page integerValue] : _pageFirst;
    
    if (self.currentVC && [self.currentVC scrollFromClickEvent] && (_row + 1 != self.currentSwitchBtnIndex)) {
        NSLog(@"不需要刷新-非显示cell");
        return;
    }
    
    _arrayData = [self.dataForRowArray objectForKey:[self keyForCurrentData]];
    if (_arrayData.count == 0) {
        [self viewWillAppear:_row];
        [self.currentScrollView.mj_header endRefreshing];
        if (self.currentVC.switchViewStyle.needFistRefresh) {
            [self.currentScrollView.mj_header beginRefreshing];
        }else if(self.enableHeaderRefresh){
            [self loadTopData];
        }
     
    }else{
        if (self.isTableViewContoller) {
            [self.tableView reloadData];
        }else{
            [self.subCollectionView reloadData];
        }
        [self viewWillAppear:_row];
    }
    
//    [self viewWillAppear:_row];
}


- (void)setEnableHeaderRefresh:(BOOL)enableHeaderRefresh{
    _enableHeaderRefresh = enableHeaderRefresh;
    if (_enableHeaderRefresh) {
        self.currentScrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadTopData)];
        if (_mjRefreshColor) {
            self.currentScrollView.mj_header.backgroundColor = self.mjRefreshColor;
        }
       
    }else{
        self.currentScrollView.mj_header = nil;
    }
}

- (void)setEnableFooterRefresh:(BOOL)enableFooterRefresh{
    //上拉加载更多
    _enableFooterRefresh = enableFooterRefresh;
    if (_enableFooterRefresh) {
        self.currentScrollView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        if (_mjRefreshColor) {
            self.currentScrollView.mj_footer.backgroundColor = self.mjRefreshColor;
        }
    }else{
        self.currentScrollView.mj_footer = nil;
    }
}

- (SuccessBlock)successBlock{
    if (!_successBlock) {
        __weak typeof(self) weakSelf = self;
        _successBlock = ^(NSArray * array){
            __strong typeof(self) strongSelf = weakSelf;
            NSArray * tempArray = array ? array : @[];
            [strongSelf setApiStatus:tempArray];
            [strongSelf setEndRefresh:tempArray];
           
            
            //读取当前所有的数据
            NSString * keyForData = [strongSelf keyForCurrentData];
            NSMutableArray * arrayReslust = [strongSelf.dataForRowArray objectForKey:keyForData];
            arrayReslust =  arrayReslust ? arrayReslust :@[].mutableCopy;
            if (strongSelf.page == strongSelf.pageFirst) {
                [arrayReslust removeAllObjects];
                [strongSelf.dataForRowArray removeObjectForKey:keyForData];
            }
            
            if (tempArray.count > 0) {
                [arrayReslust addObjectsFromArray:tempArray];
            }
           
            //TODO:保存到字典里面
            [strongSelf.dataForRowArray setObject:arrayReslust forKey:keyForData];
            
            //每次操作完成，要更新数组
            strongSelf.arrayData = arrayReslust.copy;
            NSLog(@"write array to dic,数组个数Row=%ld,count=%ld\n",strongSelf.row,(long)strongSelf.arrayData.count);
            if (strongSelf.isTableViewContoller) {
                [strongSelf.tableView reloadData];
            }else{
                [strongSelf.subCollectionView reloadData];
            }
            
           
        };
        
    }
    return _successBlock;
}

- (FailureBlock)failureBlock{
    if (!_failureBlock) {
        __weak typeof(self) weakSelf = self;
        _failureBlock = ^(NSError * error){
            __strong typeof(self) strongSelf = weakSelf;
            strongSelf.page --;//reset
            [strongSelf setEndRefresh:nil];
            if (strongSelf.arrayData.count == 0) {
                strongSelf.dataStatusType = @(CCDataStatusNoData);
                [strongSelf.tableView reloadData];
            }
            else
                strongSelf.dataStatusType = @(CCDataStatusIncompleteData);
            
        };
    }
    return _failureBlock;
    
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sc_reciveMemoryWarningNotification:) name:TQLCS_ReceiveMemoryWarningNotification object:nil];
}

- (void)sc_reciveMemoryWarningNotification:(NSNotification *)noti
{
     //可重写
    if(self.currentVC.memoryAutoClear){
        [self deleteArrayData];
    }
}

- (void)setEndRefresh:(NSArray *)array{
    if (self.page == self.pageFirst) {
        [self.currentScrollView.mj_header endRefreshing];
        if (!array || array.count == 0) {
            self.currentScrollView.mj_footer.alpha = 0;
        }
        else{
            self.currentScrollView.mj_footer.alpha = 1;
        }
    }
    
    if (!array || array.count < self.pageRows) {
        [self.currentScrollView.mj_footer endRefreshingWithNoMoreData];
    }
    else{
        [self.currentScrollView.mj_footer endRefreshing];
    }
    
}

- (void)setApiStatus:(NSArray *)array{
    /*下拉*/
    if ((!array || array.count == 0) && (self.page == self.pageFirst)) {
        self.dataStatusType = @(CCDataStatusNoData);
        return;
    }
    if (array.count < self.pageRows) {
        self.dataStatusType = @(CCDataStatusIncompleteData);
    }else{
        self.dataStatusType = @(CCDataStatusOk);
    }
}

- (void)setPageFirst:(NSInteger)pageFirst{
    _pageFirst = pageFirst;
    _page = _pageFirst;
}

- (void)setCurrentVC:(TQLClassifyScrollVC *)currentVC{
    _currentVC = currentVC;
}

- (TQLSwitchViewTool *)switchViewTool{
    return _currentVC.switchViewTool;
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
    
//    if ([self.currentVC.view.superview isKindOfClass:[UIScrollView class]]) {
//        NSArray * arrayScrollView = [self getScrollViewSuper];
//        __block BOOL canHandle = YES;
//        [arrayScrollView enumerateObjectsUsingBlock:^(UIScrollView * superScrollView, NSUInteger idx, BOOL * _Nonnull stop) {
//            NSInteger maxScrollView = superScrollView.contentSize.height - superScrollView.frame.size.height;
//            if (self.currentVC.switchViewStyle.maxOffsetY) {
//                maxScrollView = self.currentVC.switchViewStyle.maxOffsetY;
//            }
//            if (superScrollView.contentOffset.y < maxScrollView) {
//                canHandle =  NO;
//                *stop = YES;
//            }
//        }];
//
//        if (!canHandle) {
//            return canHandle;
//        }
//    }
    
    return [super pointInside:point withEvent:event];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint translate = [scrollView.panGestureRecognizer translationInView:scrollView];
    NSArray * arrayScrollView = [self getScrollViewSuper];
    if (arrayScrollView.count > 0) {//下
        __block  BOOL needScroll = NO;
        if (translate.y > 0) {
            if (scrollView.contentOffset.y < 0 ) {
                [arrayScrollView enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(UIScrollView * superScrollView, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (superScrollView.contentOffset.y > 0) {
                        NSInteger offsetY = MAX(superScrollView.contentOffset.y - translate.y, 0);
                        [superScrollView setContentOffset:CGPointMake(0, offsetY) animated:NO];
                        needScroll = YES;
                        *stop = YES;
                    }
                }];
                if (needScroll) {
                    [scrollView setContentOffset:CGPointZero animated:NO];
                }

                return;
            }
        }else{
            [arrayScrollView enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(UIScrollView * superScrollView, NSUInteger idx, BOOL * _Nonnull stop) {
                NSInteger maxScrollView = superScrollView.contentSize.height - superScrollView.frame.size.height;
                if (self.currentVC.switchViewStyle.maxOffsetY) {
                    maxScrollView = self.currentVC.switchViewStyle.maxOffsetY;
                }
                if (superScrollView.contentOffset.y < maxScrollView) {
                    NSInteger offsetY = MIN(superScrollView.contentOffset.y - translate.y, maxScrollView);
                    [superScrollView setContentOffset:CGPointMake(0, offsetY) animated:NO];
                    needScroll = YES;
                    *stop = YES;
                }
            }];
            if (needScroll) {
                [scrollView setContentOffset:CGPointZero animated:NO];
            }
        }
    }
}

- (NSArray *)getScrollViewSuper{
    UIScrollView * scrollView = nil;
    NSMutableArray * array = [NSMutableArray new];
    UIView * superView = self.currentVC.view.superview;
    while (superView) {
        if ([superView isMemberOfClass:[UIScrollView class]] || [superView isMemberOfClass:[UICollectionView class]] || [superView isMemberOfClass:[UITableView class]]) {
            [array addObject:superView];
        }
        superView = superView.superview;
    }
    return array;
}

#pragma mark -- 接口网络请求

- (void)loadTopData{
    self.page = self.pageFirst;
    [self basicRequestData];
}

- (void)setPage:(NSInteger)page{
    _page = (page >= self.pageFirst) ? page : self.pageFirst;
    [self.pageForIndex setObject:@(_page) forKey:@(self.row)];
}

- (void)loadMoreData{
    self.page ++;
    [self basicRequestData];
}

- (void)basicRequestData {
    NSAssert(NO, @"子类必须重写");
}

- (NSString *)keyForCurrentData{
    return [NSString stringWithFormat:@"%zd",self.row];
}

- (BOOL)deleteObjFromArrayData:(NSInteger)index needReload:(BOOL)needReload
{
    if ((index + 1) == self.currentSwitchBtnIndex) {
        return NO;
    }
     //读取当前所有的数据
     NSString * keyForData = [self keyForCurrentData];
     NSMutableArray * arrayReslust = [self.dataForRowArray objectForKey:keyForData];
     arrayReslust =  arrayReslust ? arrayReslust :@[].mutableCopy;
    
     if (index < arrayReslust.count) {
         [arrayReslust removeObjectAtIndex:index];
         //TODO:保存到字典里面
         [self.dataForRowArray setObject:arrayReslust forKey:keyForData];
         //每次操作完成，要更新数组
         self.arrayData = arrayReslust.copy;
         NSLog(@"write array to dic,数组个数Row=%zd,count=%ld\n",self.row,self.arrayData.count);
         if (!needReload) {
             return YES;
         }
         if (self.isTableViewContoller) {
             [self.tableView reloadData];
         }else{
             [self.subCollectionView reloadData];
         }
         return YES;

     }
    return NO;
}

- (void)deleteArrayData
{
    NSString * keyForData = [self keyForCurrentData];
    NSMutableArray * arrayReslust = [self.dataForRowArray objectForKey:keyForData];
    arrayReslust =  arrayReslust ? arrayReslust :@[].mutableCopy;
    [arrayReslust removeAllObjects];
    [self.dataForRowArray setObject:arrayReslust forKey:keyForData];
    
}


#pragma mark -- 当前的分类按钮
- (TQLRedBadgeBttton *)currentSwitchBtn{
    return self.switchToolBtnArray[self.row];
}

- (NSString *)currentSwitchItem{
    return self.switchToolItemArray[self.row];
}
 

@end

