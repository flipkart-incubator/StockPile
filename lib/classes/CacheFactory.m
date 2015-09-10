//
//  CacheFactory.m
//  Pods
//
//  Created by Prabodh Prakash on 04/09/15.
//
//

#import "CacheFactory.h"
#import "NSObject+CacheBuilder.h"
#import "LRUCache.h"
#import "LRUDBCache.h"
#import "LRUDiskCache.h"
#import "CachingException.h"

#define DEFAULT_MAX_ELEMENT_IN_MEMORY 100
#define DEFAULT_MAX_MEMORY 10

@implementation CacheFactoryDataSource

- (NSInteger) maximumElementInMemory
{
    if (_maximumElementInMemory  <= 0)
    {
        _maximumElementInMemory = DEFAULT_MAX_ELEMENT_IN_MEMORY;
    }
    
    return _maximumElementInMemory;
}

- (NSInteger) maximumMemoryAllocated
{
    if (_maximumMemoryAllocated  <= 0)
    {
        _maximumMemoryAllocated = DEFAULT_MAX_MEMORY;
    }
    
    return _maximumMemoryAllocated;
}

- (id <CacheProtocol>) cachingDBDelegate
{
    if (!_cachingDBDelegate)
    {
        _cachingDBDelegate = [[CachingDatabaseHandler alloc] init];
    }
    
    return _cachingDBDelegate;
}

- (id <CacheProtocol>) cachingDiskDelegate
{
    if (!_cachingDiskDelegate)
    {
        _cachingDiskDelegate = [[CachingDiskHandler alloc] init];
    }
    
    return _cachingDiskDelegate;
}

@end

@implementation CacheFactory

+ (id<CacheProtocol>) getCacheWithPolicy: (CachingPolicyEnum) cachePolicy cacheFactoryDataSource:(CacheFactoryDataSource*) dataSource
{
    BOOL isFallback = false;
    NSMutableArray* cacheArray = [NSMutableArray new];
    CachingManager* cachingManager = nil;
    
    LRUCache* inMemoryCache = [self inMemoryCacheWithDataSource:dataSource];
    inMemoryCache.maxMemoryAllocated = dataSource.maximumMemoryAllocated;
    inMemoryCache.maxElementsInMemory = dataSource.maximumElementInMemory;
    inMemoryCache.index = 0;
    
    switch (cachePolicy)
    {
        case MEMORY:
        {
            [cacheArray addObject:inMemoryCache];
            break;
        }
        case DISK_PERSISTENCE:
        {
            LRUDiskCache* diskCache = [self diskCacheWithDataSource:dataSource];
            diskCache.index = 1;
            
            [cacheArray addObject:inMemoryCache];
            [cacheArray addObject:diskCache];
            
            break;
        }
        case DB_PERSISTENCE:
        {
            LRUDBCache* dbCache = [self dbCacheWithDataSource:dataSource];
            dbCache.index = 1;
            
            [cacheArray addObject:inMemoryCache];
            [cacheArray addObject:dbCache];
            
            break;
        }
        case DISK_FALLBACK:
        {
            LRUDiskCache* diskCache = [self diskCacheWithDataSource:dataSource];
            diskCache.index = 1;
            
            [cacheArray addObject:inMemoryCache];
            [cacheArray addObject:diskCache];
            
            isFallback = true;
            
            break;
        }
        case DB_FALLBACK:
        {
            LRUDBCache* dbCache = [self dbCacheWithDataSource:dataSource];
            dbCache.index = 1;
            
            [cacheArray addObject:inMemoryCache];
            [cacheArray addObject:dbCache];
            
            isFallback = true;
            
            break;
        }
    }
    
    cachingManager = [[CachingManager alloc] initWithCacheArray:cacheArray];
    cachingManager.isFallback = isFallback;
    
    return cachingManager;
}

+ (LRUCache*) inMemoryCacheWithDataSource: (CacheFactoryDataSource*) dataSource
{
    __block CacheFactoryDataSource* blockDataSource = dataSource;
    
    return [[LRUCache alloc] initUsingBlock:^(LRUCache* cache)
             {
                 cache.maxElementsInMemory = [blockDataSource maximumElementInMemory];
                 cache.maxMemoryAllocated = [blockDataSource maximumMemoryAllocated];
             }];
}

+ (LRUDBCache*) dbCacheWithDataSource: (CacheFactoryDataSource*) dataSource
{
    __block CacheFactoryDataSource* blockDataSource = dataSource;
    
    return [[LRUDBCache alloc] initUsingBlock:^(LRUDBCache* cache)
            {
                cache.pathForDBCaching = [blockDataSource dbIdentifier];
                cache.cachingDatabaseDelegate = [blockDataSource cachingDBDelegate];
                [cache.cachingDatabaseDelegate setPath:[blockDataSource dbIdentifier]];
            }];
}

+ (LRUDiskCache*) diskCacheWithDataSource: (CacheFactoryDataSource*) dataSource
{
    __block CacheFactoryDataSource* blockDataSource = dataSource;
    
    return [[LRUDiskCache alloc] initUsingBlock:^(LRUDiskCache* cache)
            {
                cache.pathForDiskCaching = [blockDataSource pathForDiskCaching];
                cache.cachingDiskProtocol = [blockDataSource cachingDiskDelegate];
                [cache.cachingDiskProtocol setPath:[blockDataSource pathForDiskCaching]];
            }];
}

@end