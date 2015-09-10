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

@property (nonatomic, strong) NSArray* cacheArray;

@end

@interface CachingManager()
{
    dispatch_queue_t serialQueue;
}

@end

@implementation CachingManager
@synthesize path;

- (instancetype) initWithCacheArray: (NSArray*) cacheArray;
{
    self = [super init];
    
    if (self)
    {
        _cacheArray = cacheArray;
        
        serialQueue = dispatch_queue_create("com.caching", DISPATCH_QUEUE_SERIAL);
    }
    
    return self;
}

- (BOOL) cacheNode: (Node*) node
{
    dispatch_sync(serialQueue, ^{
        
        if (_isFallback)
        {
            [[_cacheArray objectAtIndex:0] cacheNode:node];
        }
        else
        {
            for (id<CacheProtocol> cache in _cacheArray)
            {
                [cache cacheNode:node];
            }
        }
    });
    
    return true;
}

- (Node*) getNodeForKey:(NSString*) key
{
    __block Node* node = nil;
    dispatch_sync(serialQueue, ^{
        
        int i = 0;
        while (i <  [_cacheArray count] && node.data == nil)
        {
            id<CacheProtocol> cache = [_cacheArray objectAtIndex:i++];
            node = [cache getNodeForKey:key];
        }
    });
    
    return node;
}

- (void) clearCache
{
    dispatch_sync(serialQueue, ^{
        
        int i = 0;
        if (i <  [_cacheArray count])
        {
            id<CacheProtocol> cache = [_cacheArray objectAtIndex:i++];
            [cache clearCache];
        }
    });
}

#pragma mark CacheFallbackProtocal methods

- (void) handleEvictedNodes: (NSArray*) evictedNodes evictedAtIndex:(int) index
{
    if (!_isFallback || index >= [_cacheArray count] -1)
        return;
    
    id<CacheProtocol> nextCache = _cacheArray[index +1];
    
    for (Node* node in evictedNodes)
    {
        [nextCache cacheNode:node];
    }
}

@end