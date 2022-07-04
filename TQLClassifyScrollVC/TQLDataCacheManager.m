//
//  TQLDataCacheManager.m
//  TQLClassifyScrollVC
//
//  Created by litianqi on 2021/12/7.
//

#import "TQLDataCacheManager.h"
#import <objc/runtime.h>
#import "TQLViewContorller.h"



static inline BOOL IsEmpty(id thing) {
    return thing == nil || [thing isEqual:[NSNull null]] ||
    ([thing respondsToSelector:@selector(length)] && [(NSData *)thing length] == 0) ||
    ([thing respondsToSelector:@selector(count)] && [(NSArray *)thing count] == 0);

}

static inline BOOL IsNeedIgnoreType(id thing) {
    return  ([thing isKindOfClass:[UIResponder class]]);

}



@implementation TQLPageDataCache

@end




@interface TQLPageDataAutoCache()
@property(strong,atomic) NSMutableDictionary * tql_allDataDic;
@end

@implementation TQLPageDataAutoCache

- (NSMutableDictionary *)tql_allDataDic
{
    if (!_tql_allDataDic) {
        _tql_allDataDic = @{}.mutableCopy;
    }
    return _tql_allDataDic;
}

- (void)saveAllData:(TQLViewContorller *)viewController
{
    unsigned int count = 0;
    Ivar * properList = class_copyIvarList([viewController class], &count);
    NSMutableArray * arrayrPName = @[].mutableCopy;
    for (int i = 0; i < count; i++) {
        Ivar  property = properList[i];
//        const char * name = property_getName(property);
        const char *name = ivar_getName(property);
        NSString *  nameStr = [NSString stringWithUTF8String:name];
        id value = [viewController valueForKey:nameStr];
        if (!IsEmpty(value)) {
            NSArray * needCacheArray = [viewController tq_needCacheKeyArray];
            NSArray * ignoreArray = [viewController tq_ignoreKeyArray];
            if ([needCacheArray containsObject:nameStr]) {
                [self.tql_allDataDic setObject:value forKey:nameStr];
                [arrayrPName addObject:nameStr];
                 
            } else if (![ignoreArray containsObject:nameStr] && !IsNeedIgnoreType(value)) {
                [self.tql_allDataDic setObject:value forKey:nameStr];
                [arrayrPName addObject:nameStr];
            }else {
                NSLog(@"忽略");
            }
        }
    }
    free(properList);
    NSLog(@"%@",arrayrPName);
    
}


- (void)recoverAllDataFromCache:(TQLViewContorller *)viewController
{
    [self.tql_allDataDic enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [viewController setValue:obj forKey:key];
    }];
    
//   id obj =  [viewController valueForKey:@"_test1"];
//    NSLog(@"%@",viewController);
    
}


@end


@interface TQLDataCacheManager ()
{
    NSMutableDictionary * _allData;
    NSMutableDictionary * _allAutoPageData;
}
@end

@implementation TQLDataCacheManager

- (instancetype)init
{
    if (self = [super init]) {
        _allData = @{}.mutableCopy;
        _allAutoPageData = @{}.mutableCopy;
    }
    return self;
}

- (BOOL)checkIsNeedCreate:(NSString *)keyId autoCache:(BOOL)autoCache
{
    if (autoCache) {
        if ([_allAutoPageData objectForKey:keyId]) {
            return NO;
        }
    }else{
        if ([_allData objectForKey:keyId]) {
            return NO;
        }
    }
    return YES;
}

- (void)create:(NSString *)keyId classStr:(NSString *)classPageData  autoCache:(BOOL)autoCache
{
    if (autoCache) {
        [self auto_create:keyId classStr:classPageData];
    }else{
        [self tq_create:keyId classStr:classPageData];
    }
}

- (TQLPageDataCache *)allCacheForKeyId:(NSString *)keyId autoCache:(BOOL)autoCache
{
    if (autoCache) {
        TQLPageDataAutoCache * obj = [_allAutoPageData objectForKey:keyId];
        return obj;
    }else{
        TQLPageDataCache * obj = [_allData objectForKey:keyId];
        return obj;
    }
  
}

@end


@implementation TQLDataCacheManager (PageCache)
- (BOOL)tq_checkIsNeedCreate:(NSString *)keyId
{
    if ([_allData objectForKey:keyId]) {
        return NO;
    }
    return YES;
}

- (void)tq_create:(NSString *)keyId classStr:(NSString *)classPageData
{
    TQLPageDataCache * obj = [TQLPageDataCache new];
    if (classPageData.length) {
        if (NSClassFromString(classPageData)) {
            obj = [NSClassFromString(classPageData) new];
        }
    }
    
    obj.key_id_TQL = keyId;
    [_allData setObject:obj forKey:keyId];
}

- (TQLPageDataCache *)tq_allCacheForKeyId:(NSString *)keyId
{
    TQLPageDataCache * obj = [_allData objectForKey:keyId];
    return obj;
}

@end


@implementation TQLDataCacheManager (AutoCache)

- (BOOL)auto_checkIsNeedCreate:(NSString *)keyId
{
    if ([_allAutoPageData objectForKey:keyId]) {
        return NO;
    }
    return YES;
}

- (void)auto_create:(NSString *)keyId classStr:(NSString *)classPageData
{
    TQLPageDataAutoCache * obj = [TQLPageDataAutoCache new];
    if (classPageData.length) {
        if (NSClassFromString(classPageData)) {
            obj = [NSClassFromString(classPageData) new];
        }
    }
    
    obj.key_id_TQL = keyId;
    [_allAutoPageData setObject:obj forKey:keyId];
}

- (TQLPageDataAutoCache *)auto_allCacheForKeyId:(NSString *)keyId
{
    TQLPageDataAutoCache * obj = [_allAutoPageData objectForKey:keyId];
    return obj;
}
@end
