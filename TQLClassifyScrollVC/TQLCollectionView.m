//
//  TQLCollectionView.m
//  TQLClassifyScrollVC
//
//  Created by litianqi on 2021/12/21.
//

#import "TQLCollectionView.h"


@interface TQLCollectionView ()<UIGestureRecognizerDelegate>
@property(nonatomic,assign) CGPoint beginPoint;
@end


@implementation TQLCollectionView

- (void)dealloc
{
    NSLog(@"%s",__func__);
}


- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
//        [self.panGestureRecognizer addTarget:self action:@selector(handlePanG:)];
        NSLog(@"");
    }
    return self;
}

//- (void)handlePanG:(UIPanGestureRecognizer *)panG
//{
//    __block BOOL canScroll = NO;
//    NSArray * subCollection = [[self class] getScrollViewSub:self];
//    if (subCollection.count == 0) {
//        return;
//    }
//    if (panG.state == UIGestureRecognizerStateBegan) {
//        _beginPoint = self.contentOffset;
//    }
//
//    CGPoint point = [panG locationInView:self];
//    [subCollection enumerateObjectsUsingBlock:^(TQLCollectionView * obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        CGFloat widthCollection = obj.bounds.size.width;
//        CGFloat offsetX = obj.contentOffset.x;
//        CGFloat contentWith = obj.contentSize.width;
//
//        ///main不可以滑动
//        if ((offsetX + widthCollection) >= contentWith || offsetX <= 0) {
//            canScroll = YES;
//            *stop = YES;
//        }
//        else if (obj.contentOffset.x > 0 && (offsetX + widthCollection < contentWith ) ) {
//            canScroll = NO;
//            *stop = YES;
//        }
//    }];
//
//    if (!canScroll) {
//        [self setContentOffset:self.beginPoint];
//    }
//
//}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//
//    return NO;
//    __block BOOL _isShouldSimultRecognize = YES;
//    NSArray * subCollection = [[self class] getScrollViewSub:self];
//    CGPoint point = [gestureRecognizer locationInView:self];
//    [subCollection enumerateObjectsUsingBlock:^(TQLCollectionView * obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        CGFloat widthCollection = obj.bounds.size.width;
//        CGFloat offsetX = obj.contentOffset.x;
//        CGFloat contentWith = obj.contentSize.width;
//
//        ///main不可以滑动
////        if ((offsetX + widthCollection) > contentWith || offsetX < 0) {
////            _isShouldSimultRecognize = YES;
////            *stop = YES;
////        }
//         if (obj.contentOffset.x > 0 && (offsetX + widthCollection < contentWith ) ) {
//            _isShouldSimultRecognize = NO;
//            *stop = YES;
//        }
//    }];
//    if (subCollection.count == 0) {
//        return NO;
//    }
//    return _isShouldSimultRecognize;
////
////    return _isShouldSimultRecognize;
//}

//+ (NSArray *)getScrollViewSub:(UIView *)view{
//    
//    NSMutableArray *array = [NSMutableArray new];
//    NSArray *subView = view.subviews;
//    if ([view isKindOfClass:[UICollectionView class]]) {
//        UICollectionView * collection = view;
//        subView = collection.visibleCells;
//    }else  if ([view isKindOfClass:[UITableView class]]) {
//        UITableView *tableView = view;
//        subView = tableView.visibleCells;
//    }
//
//    if (subView.count && ![view isKindOfClass:[UIButton class]]) {
//        UIScrollView *scrollView = nil;
//      
//        NSArray *subviews = subView;
//        
//        [subviews enumerateObjectsUsingBlock:^(TQLCollectionView *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            if ([obj isKindOfClass:[TQLCollectionView class]] && obj.isPage) {
//                [array addObject:obj];
//            }
//            
//            if (obj.subviews.count) {
//               NSArray *subArray = [self getScrollViewSub:obj];
//                [array addObjectsFromArray:subArray];
//            }
//            
//        }];
//    
//    }
//    return array;
//   
//}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
