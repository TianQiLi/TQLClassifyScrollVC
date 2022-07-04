//
//  TQLDataCacheManager.h
//  TQLClassifyScrollVC
//
//  Created by litianqi on 2021/12/7.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@class TQLViewContorller;
//页码数据类
@interface TQLPageDataCache : NSObject
@property (nonatomic, strong)NSString * key_id_TQL;
@property (nonatomic, assign)NSInteger row;

//- (void)saveAllData:(TQLViewContorller *)viewController;
//- (void)recoverAllDataFromCache:(TQLViewContorller *)viewController;

@end

//自动存储类
@interface TQLPageDataAutoCache : TQLPageDataCache
//@property (atomic, strong)NSString * key_id;
//@property (assign, atomic)NSInteger row;

- (void)saveAllData:(TQLViewContorller *)viewController;
- (void)recoverAllDataFromCache:(TQLViewContorller *)viewController;

@end



@interface TQLDataCacheManager : NSObject

///如果没有row 的对象，就生成
- (BOOL)checkIsNeedCreate:(NSString *)keyId autoCache:(BOOL)autoCache;
- (void)create:(NSString *)keyId classStr:(NSString *)classPageData autoCache:(BOOL)autoCache;

- (TQLPageDataCache *)allCacheForKeyId:(NSString *)keyId  autoCache:(BOOL)autoCache;
@end

@interface TQLDataCacheManager (PageCache)
///如果没有row 的对象，就生成
- (BOOL)tq_checkIsNeedCreate:(NSString *)keyId;
- (BOOL)tq_checkIsNeedCreate:(NSString *)keyId;
- (void)tq_create:(NSString *)keyId classStr:(NSString *)classPageData;

- (TQLPageDataCache *)tq_allCacheForKeyId:(NSString *)keyId;
@end


@interface TQLDataCacheManager (AutoCache)

///如果没有row 的对象，就生成
- (BOOL)auto_checkIsNeedCreate:(NSString *)keyId;
- (void)auto_create:(NSString *)keyId classStr:(NSString *)classPageData;

- (TQLPageDataCache *)auto_allCacheForKeyId:(NSString *)keyId;
@end

NS_ASSUME_NONNULL_END
