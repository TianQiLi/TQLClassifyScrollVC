//
//  TQLCollectionViewCell+DZNEmptyDataSet.m
//  AFDownloadRequestOperation
//
//  Created by litianqi on 2018/6/22.
//

#import "TQLCollectionViewCell+DZNEmptyDataSet.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import <objc/runtime.h>
#import "TQLClassifyScrollVC_Header.h"
static  NSString * const DefaultErrorText =@"网络不给力,点击屏幕刷新";
static  NSString * const DefaultNodataText =@"暂无内容";

static  NSString * const DefaultUnKnowndataText =@"努力加载中...";


static char const * const DataStatusTypeKey = "DataStatusType";
static char const * const DataStatusUnknownTextKey = "DataStatusUnknownTextKey";
static char const * const DataStatusUnknownImgKey = "DataStatusUnknownImgKey";

static char const * const DataStatusErrorTextKey = "DataStatusErrorText";
static char const * const DataStatusErrorImgKey = "DataStatusErrorImgKey";


static char const * const DataStatusNoDataTextKey = "DataStatusNoDataText";

static char const * const DataStatusNoDataFontSizeKey = "DataStatusNoDataFontSize";
static char const * const DataStatusNoDataImgKey = "DataStatusNoDataImg";
static char const * const VerticalOffset = "VerticalOffset";
static char const * const SpaceHeightKey = "SpaceHeightKey";

static char const * const DataStatusTextColorKey = "DataStatusTextColorKey";
static char const * const DataStatusEmptyBgColorKey = "DataStatusEmptyBgColorKey";


@implementation TQLCollectionViewCellBase (DZNEmptyDataSet)

-(NSNumber*)dataStatusType{
    return objc_getAssociatedObject(self, DataStatusTypeKey);
}

-(void)setDataStatusType:(NSNumber*)dataStatusType{
    objc_setAssociatedObject(self, DataStatusTypeKey, dataStatusType, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSNumber*)dataStatusNoData_text_fontSize{
    return objc_getAssociatedObject(self, DataStatusNoDataFontSizeKey);
}

-(void)setDataStatusNoData_text_fontSize:(NSNumber *)dataStatusNoData_text_fontSize{
    objc_setAssociatedObject(self, DataStatusNoDataFontSizeKey, dataStatusNoData_text_fontSize, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)dataStatusUnknown_text{
    return objc_getAssociatedObject(self, DataStatusUnknownTextKey);
}

- (void)setDataStatusUnknown_text:(NSString *)dataStatusUnknown_text{
    objc_setAssociatedObject(self, DataStatusUnknownTextKey, dataStatusUnknown_text, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)dataStatusUnknown_img{
    return objc_getAssociatedObject(self, DataStatusUnknownImgKey);
}

- (void)setDataStatusUnknown_img:(NSString *)dataStatusUnknown_img{
    objc_setAssociatedObject(self, DataStatusUnknownImgKey, dataStatusUnknown_img, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


-(NSString*)dataStatusError_text{
    return objc_getAssociatedObject(self, DataStatusErrorTextKey);
}

-(void)setDataStatusError_text:(NSString *)dataStatusError_text{
    objc_setAssociatedObject(self, DataStatusErrorTextKey, dataStatusError_text, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)dataStatusError_img{
    return objc_getAssociatedObject(self, DataStatusErrorImgKey);
}

- (void)setDataStatusError_img:(NSString *)dataStatusError_img{
    objc_setAssociatedObject(self, DataStatusErrorImgKey, dataStatusError_img, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


-(NSString *)dataStatusNoData_text{
    return objc_getAssociatedObject(self, DataStatusNoDataTextKey);
}

-(void)setDataStatusNoData_text:(NSString *)dataStatusNoData_text{
    objc_setAssociatedObject(self, DataStatusNoDataTextKey, dataStatusNoData_text, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)dataStatusNoData_img{
    return objc_getAssociatedObject(self, DataStatusNoDataImgKey);
}

-(void)setDataStatusNoData_img:(NSString *)dataStatusNoData_img{
    objc_setAssociatedObject(self, DataStatusNoDataImgKey, dataStatusNoData_img, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSNumber *)verticalOffset{
    return objc_getAssociatedObject(self, VerticalOffset);
}

-(void)setVerticalOffset:(NSNumber *)verticalOffset{
    objc_setAssociatedObject(self, VerticalOffset, verticalOffset, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSNumber *)spaceHeight{
    return objc_getAssociatedObject(self, SpaceHeightKey);
}

-(void)setSpaceHeight:(NSNumber *)spaceHeight{
    objc_setAssociatedObject(self, SpaceHeightKey, spaceHeight, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (NSString *)dataStatusTextColor{
    return objc_getAssociatedObject(self, DataStatusTextColorKey);
}

- (void)setDataStatusTextColor:(NSString *)dataStatusTextColor{
    return objc_setAssociatedObject(self, DataStatusTextColorKey, dataStatusTextColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}


- (NSString *)dataStatusEmptyBGColor{
    return objc_getAssociatedObject(self, DataStatusEmptyBgColorKey);
}

- (void)setDataStatusEmptyBGColor:(NSString *)dataStatusEmptyBGColor{
    return objc_setAssociatedObject(self, DataStatusEmptyBgColorKey, dataStatusEmptyBGColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


#pragma mark --DZNEmptyDataSetDelegate
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    UIColor * color = nil;
    if (self.dataStatusEmptyBGColor) {
        color = [[self class] colorWithHexString:self.dataStatusEmptyBGColor];
    }else{
        color =  [[self class] colorWithHexString:@"0xf4f6f9"];
    }
    
    return [[self class] tq_CellBgColor:color];
    
}



+ (UIColor *)tq_WhiteColor:(UIColor *)lightColor
{
    return [[self class] tq_LightColor:lightColor DarkColor:[[self class] colorWithHexString:@"0x444444"]];
}

+ (UIColor *)tq_CellBgColor:(UIColor *)lightColor
{
   return [[self class] tq_LightColor:lightColor DarkColor:[[self class] colorWithHexString:@"0x444444"]];
}

+ (UIColor *)tq_ViewBgColor:(UIColor *)lightColor
{
    
    return [[self class] tq_LightColor:lightColor DarkColor:[[self class] colorWithHexString:@"0x333333"]];
}

+ (UIColor *)tq_LightColor:(UIColor *)lightColor DarkColor:(UIColor *)darkColor
{
    UIColor *dyColor;
    if (!darkColor) {
        darkColor = [[self class] colorWithHexString:@"0x444444"];
    }
    if (@available(iOS 13.0, *)) {
        dyColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trainCollection) {
            if ([trainCollection userInterfaceStyle] == UIUserInterfaceStyleDark) {
                return darkColor;
            }
            else {
                return lightColor;
            }
        }];
    } else {
        dyColor = lightColor;
    }
    
    return dyColor;
}


- (UIView *)tq_loadingViewForEmpty
{
    return nil;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString * imgUrl = @"";
    if ([self.dataStatusType integerValue] == CCDataStatusNoData) {
        imgUrl = @"TQL_NoData_icon";
        if (self.dataStatusNoData_img && self.dataStatusNoData_img.length > 0) {
            imgUrl = self.dataStatusNoData_img;
        }else{
            return TQLClassifyScrollImage(imgUrl);
        }
        UIImage *img = [UIImage imageNamed:imgUrl];
        return img;
    } else if ([self.dataStatusType integerValue] == CCDataStatusError) {
        imgUrl = @"TQL_error";
        if (self.dataStatusError_img && self.dataStatusError_img.length > 0) {
            imgUrl = self.dataStatusError_img;
        }else{
            return TQLClassifyScrollImage(imgUrl);
        }
        return [UIImage imageNamed:imgUrl];
    }else if ([self.dataStatusType integerValue] == CCDataStatusNoKnown) {
        imgUrl = self.dataStatusUnknown_img ? self.dataStatusUnknown_img : imgUrl;
        return [UIImage imageNamed:imgUrl];
    }
    else
        return nil;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"";
    if ([self.dataStatusType integerValue] == CCDataStatusNoData) {
        text = self.dataStatusNoData_text;
        if (!text || text.length == 0) {
            text = DefaultNodataText;
        }
    }
    else if ([self.dataStatusType integerValue] == CCDataStatusError) {
        text = self.dataStatusError_text;
        if (!text || text.length == 0) {
            text = DefaultErrorText;
        }
    }
    else if ([self.dataStatusType integerValue] == CCDataStatusNoKnown){
//        text = self.dataStatusUnknown_text;
//        if (!text || text.length == 0) {
//            text = DefaultUnKnowndataText;
//        }
        text = @"";
    }else if ([self.dataStatusType integerValue] == CCDataStatusOk || [self.dataStatusType integerValue] == CCDataStatusIncompleteData){
        text = @"";
    }
    text = text ? text : @"";
    UIFont *font = [UIFont systemFontOfSize:16.f];
    if (self.dataStatusNoData_text_fontSize && [self.dataStatusNoData_text_fontSize integerValue]>0) {
        font = [UIFont systemFontOfSize:[self.dataStatusNoData_text_fontSize integerValue]];
    }
    UIColor * textColor = nil;
    if (self.dataStatusTextColor && self.dataStatusTextColor.length > 0) {
        textColor = [[self class] colorWithHexString:self.dataStatusTextColor];
    }else
        textColor = [[self class] colorWithHexString:@"0x969696"];
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    [attributes setObject:font forKey:NSFontAttributeName];
    [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    if (self.verticalOffset) {
        return [self.verticalOffset floatValue];
    }
    return 0;
}

- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView
{
    if ([self.dataStatusType integerValue] == CCDataStatusNoKnown) {
        return [self tq_loadingViewForEmpty];
    }
    return nil;
}


- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView{
    if (self.spaceHeight) {
        return [self.spaceHeight floatValue];
    }
    return 11;
}


+ (UIColor *)colorWithHexString:(NSString *)stringToConvert {
    NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) return nil;
    return [[self class] colorWithRGBHex:hexNum];
}

+ (UIColor *)colorWithRGBHex:(UInt32)hex {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}


@end

