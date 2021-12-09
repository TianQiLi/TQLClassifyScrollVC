//
//  TQLDataCacheManager.h
//  TQLClassifyScrollVC
//
//  Created by litianqi on 2021/12/7.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@class TQLViewContorller;
@interface TQLPageDataCache : NSObject
@property (atomic, strong)NSString * key_id;
@property (assign, atomic)NSInteger row;

- (void)saveAllData:(TQLViewContorller *)viewController;
- (void)recoverAllDataFromCache:(TQLViewContorller *)viewController;

@end


@interface TQLDataCacheManager : NSObject

///如果没有row 的对象，就生成
- (BOOL)checkIsNeedCreate:(NSString *)keyId;

- (TQLPageDataCache *)allCacheForKeyId:(NSString *)keyId;
@end

NS_ASSUME_NONNULL_END
