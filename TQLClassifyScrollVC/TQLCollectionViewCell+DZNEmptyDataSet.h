//
//  TQLCollectionViewCell+DZNEmptyDataSet.h
//  AFDownloadRequestOperation
//
//  Created by litianqi on 2018/6/22.
//


#import "UIScrollView+EmptyDataSet.h"
#import "TQLCollectionViewCell.h"
// //数据接口请求的状态
typedef NS_ENUM(NSInteger, CCDataAPIStatusType) {
    CCDataStatusNoKnown,//未知 : 请求前
    CCDataStatusOk, //成功   :成功返回
    CCDataStatusError, // 错误 :错误返回
    CCDataStatusNoData //请求成功，无数据
};

@interface UICollectionViewCell (DZNEmptyDataSet)<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nullable,nonatomic,strong) NSNumber* dataStatusType;//记录接口返回状态
@property (nullable,nonatomic,strong) NSNumber* dataStatusNoData_text_fontSize;//字体大小
@property (nullable,nonatomic,copy) NSString * dataStatusError_text;//错误文案
@property (nullable,nonatomic,copy) NSString * dataStatusError_img;//错误图片
@property (nullable,nonatomic,copy) NSString * dataStatusNoData_text;//无数据文案
@property (nullable,nonatomic,copy) NSString * dataStatusNoData_img;//无数据图片
@property (nullable,nonatomic,copy) NSString * dataStatusUnknown_text;//未知文案
@property (nullable,nonatomic,copy) NSString * dataStatusUnknown_img;//未知图片
@property (nullable,nonatomic,copy) NSNumber * verticalOffset;//图片偏移
@property (nullable,nonatomic,copy) NSNumber * spaceHeight;//item 间距
@property (nullable,nonatomic,copy) NSString * dataStatusTextColor;//默认文字颜色

@end
