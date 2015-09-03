//
//  CachingManager.m
//  Pods
//
//  Created by Prabodh Prakash on 27/08/15.
//
//

#import "CachingManager.h"
#import "CacheProtocol.h"

@interface CachingManager()

@property (nonatomic, assign) id<CacheProtocol> cache;

@end

@implementation CachingManager

+ (id)sharedManagerWithCacheType: (id<CacheProtocol>) cachingType
{
    static CachingManager *sharedCachingManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedCachingManager = [[self alloc] initWithCacheType:cachingType];
    });
    
    return sharedCachingManager;
}

- (instancetype) initWithCacheType: (id<CacheProtocol>) cachingType
{
    self = [super init];
    
    if (self)
    {
        _cache = cachingType;
    }
    
    return self;
}

- (void) cacheNode: (Node*) node
{
    [_cache cacheNode:node];
}

- (Node*) getNodeForKey:(NSString*) key
{
    return [_cache getNodeForKey:key];
}

- (void) clearCache
{
    return [_cache clearCache];
}

@end
