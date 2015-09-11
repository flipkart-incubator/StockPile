//
//  CachingManager.m
//  Pods
//
//  Created by Prabodh Prakash on 27/08/15.
//
//

#import "CachingManager.h"
#import "CachingException.h"
#import "NSObject+CacheBuilder.h"

@interface CachingManager()
{
    dispatch_queue_t serialQueue;
}

@end

@implementation CachingManager

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        serialQueue = dispatch_queue_create("com.caching", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (BOOL) cacheValue:(Value*) value forKey:(NSString *)key;
{
    __block BOOL cached = NO;
    dispatch_sync(serialQueue, ^{
        cached = [self.firstResponderCacheAlgo cacheValue:value forKey:key];
    });
    return cached;
}

- (Value*) getValueForKey:(NSString *) key;
{
    __block Value *value = nil;
    dispatch_sync(serialQueue, ^{
        value = [self.firstResponderCacheAlgo getValueForKey:key];
    });
    return value;
}

- (void) clearCacheAndCascade;
{
    dispatch_sync(serialQueue, ^{
        [self.firstResponderCacheAlgo clearCacheAndCascade];
    });
}


@end

