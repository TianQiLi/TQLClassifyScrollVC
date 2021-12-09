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

@interface TQLPageDataCache()
@property(strong,atomic) NSMutableDictionary * allDataDic;
@end

@implementation TQLPageDataCache

- (NSMutableDictionary *)allDataDic
{
    if (!_allDataDic) {
        _allDataDic = @{}.mutableCopy;
    }
    return _allDataDic;
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
            [self.allDataDic setObject:value forKey:nameStr];
        }
    
        [arrayrPName addObject:nameStr];
        
        
    }
    free(properList);
    
    NSLog(@"%@",arrayrPName);
    
}


- (void)recoverAllDataFromCache:(TQLViewContorller *)viewController
{
    [self.allDataDic enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [viewController setValue:obj forKey:key];
    }];
    
//   id obj =  [viewController valueForKey:@"_test1"];
//    NSLog(@"%@",viewController);
    
}


@end


@interface TQLDataCacheManager ()
{
    NSMutableDictionary * _allData;
}
@end

@implementation TQLDataCacheManager

- (instancetype)init
{
    if (self = [super init]) {
        _allData = @{}.mutableCopy;
    }
    return self;
}

- (BOOL)checkIsNeedCreate:(NSString *)keyId
{
    if ([_allData objectForKey:keyId]) {
        return NO;
    }
    TQLPageDataCache * obj = [TQLPageDataCache new];
    obj.key_id = keyId;
    [_allData setObject:obj forKey:keyId];
    return YES;
}

- (TQLPageDataCache *)allCacheForKeyId:(NSString *)keyId
{
    TQLPageDataCache * obj = [_allData objectForKey:keyId];
    return obj;
}

@end
