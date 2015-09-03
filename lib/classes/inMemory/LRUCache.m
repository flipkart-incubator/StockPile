//
//  LRUCache.m
//  Pods
//
//  Created by Prabodh Prakash on 01/09/15.
//
//

#import "LRUCache.h"
#import "LinkedHashMap.h"
#import "CachingException.h"

@interface LRUCache()

@property (nonatomic, strong) LinkedHashMap* linkedHashMap;
@property (nonatomic, assign) int capacity;
@property (nonatomic, assign) int currentSize;
@property (nonatomic, assign) int memoryLimit;
@property (nonatomic, assign) int currentMemoryUsage;
@property (nonatomic, assign) int hitCount;
@property (nonatomic, assign) int missCount;


@end

@implementation LRUCache

/**
 * If initialized using this method, the default memory limit is 100 MB. If memory limit is not
 * according to the requirements, use initWithMemoryLimitInMB: method to initialize the LRUCache
 *
 * @param capacity integer value which tells the quantity of items in cache
 *
 * @return The newly-initialized LRUCache
 */
- (instancetype) initWithCapacity: (int) capacity
{
    if (capacity <= 0)
    {
        @throw [[CachingException alloc] initWithReason:@"Capacity must be greater than 0"];
    }
    
    self = [super init];
    
    if (self)
    {
        _capacity = capacity;
        _memoryLimit = 100;
        _linkedHashMap = [[LinkedHashMap alloc] initWithCapacity:capacity];
    }
    
    return self;
}

/**
 * If initialized using this method, there will be no cap on the quantity of items that can be kept in
 * LRUCache. It is set to INT_MAX
 *
 * @param reason integer value that specifies the cap on memory limit in MB's
 *
 * @return The newly-initialized LRUCache
 */
- (instancetype) initWithMemoryLimitInMB:(int) memoryLimit
{
    if (memoryLimit <= 0)
    {
        @throw [[CachingException alloc] initWithReason:@"Memory limit must be greater than 0"];
    }
    
    self = [super init];
    
    if (self)
    {
        _capacity = INT_MAX;
        _memoryLimit = memoryLimit;
        _linkedHashMap = [[LinkedHashMap alloc] init];
    }
    
    return self;
}

/**
 * @param node Node type that needs to be cached
 */
- (void) cacheNode: (Node*) node
{
    if (_currentSize == _capacity)
    {
        [_linkedHashMap removeEndNode];
        _currentSize--;
    }
    
    float memoryNeeded = node.sizeOfData;
    
    while (_memoryLimit - _currentMemoryUsage < memoryNeeded)
    {
        _currentMemoryUsage -= [_linkedHashMap removeEndNode];
    }
    
    [_linkedHashMap putNode:node];
    _currentMemoryUsage += node.sizeOfData;
    
    _currentSize++;
}

/**
 * This method will retrieve the cached value against key. If the value is not present in memory,
 * it will look out in database for corresponding value.
 *
 * @param key String value for which the cached value needs to be retrieved
 *
 * @return Retrieved cached value as Node. It returns nil if no cached value is found.
 */
- (Node*) getNodeForKey:(NSString*) key
{
    Node* node = [_linkedHashMap getObject:key];
    
    if (node != nil)
    {
        _hitCount++;
        
        [_linkedHashMap moveNode:node toPosition:0];
    }
    else
    {
        _missCount++;
    }
    
    return node;
}

/**
 * This method will clear all values from cache
 */
- (void) clearCache
{
    _currentSize = 0;
    [_linkedHashMap clear];
}

@end
