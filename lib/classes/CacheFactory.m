//
//  CacheFactory.m
//  Pods
//
//  Created by Prabodh Prakash on 03/09/15.
//
//

#import "CacheFactory.h"
#import <CachingException.h>
#import <LRUCache.h>

@implementation CacheFactory

+ (id<CacheProtocol>) getCacheWithMaxElementCount: (int) elementCount
                                   maxMemoryLimit: (int) maxMemoryLimit
                                        cacheType: (CachingType) cachingType
{
    id <CacheProtocol> cache;
    
    if (elementCount > 0 && maxMemoryLimit > 0)
    {
        @throw [[CachingException alloc] initWithReason:@"Both elementCount and maxMemoryLimit cannot be greater than zero simultaneously"];
    }
    
    if (cachingType == LRU)
    {
        if (elementCount > 0)
        {
            cache = [[LRUCache alloc] initWithCapacity:elementCount];
        }
        else if (maxMemoryLimit)
        {
            cache = [[LRUCache alloc] initWithMemoryLimitInMB:maxMemoryLimit];
        }
    }
    else if (cachingType == MFU)
    {
        @throw [[CachingException alloc] initWithReason:@"MFU is not supported currently"];
    }
    
    return cache;
}

@end