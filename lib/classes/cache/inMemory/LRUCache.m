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
@property (nonatomic, assign) int currentSize;
@property (nonatomic, assign) int currentMemoryUsage;
@property (nonatomic, assign) int hitCount;
@property (nonatomic, assign) int missCount;

@end

@implementation LRUCache

@synthesize linkedHashMap = _linkedHashMap;

- (instancetype)init{
    self = [super init];
    if (self)
    {
        self.linkedHashMap = [[LinkedHashMap alloc] init];
    }
    return self;
}

- (instancetype) initWithCapacity: (int) capacity andMemoryLimit:(int) memoryLimit
{
    if (capacity <= 0)
    {
        @throw [[CachingException alloc] initWithReason:@"Capacity must be greater than 0"];
    }
    
    self = [self init];
    return self;
}

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
    
    self = [self init];
    if (self)
    {
        _maxElementsInMemory = capacity;
        _maxMemoryAllocated = 100;
        _linkedHashMap = [[LinkedHashMap alloc] init];
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
        _maxElementsInMemory = INT_MAX;
        _maxMemoryAllocated = memoryLimit;
    }
    
    return self;
}


/**
 * @param node Node type that needs to be cached
 */
- (BOOL) cacheNode: (Node*) node
{
    if (_currentSize == _maxElementsInMemory)
    {
        [[self linkedHashMap]  removeEndNode];
        _currentSize--;
    }
    
    float memoryNeeded = node.sizeOfData;
    
    while ((_maxMemoryAllocated - _currentMemoryUsage) < memoryNeeded)
    {
        _currentMemoryUsage -= [[self linkedHashMap] removeEndNode];
    }
    
    [[self linkedHashMap] putNode:node];
    _currentMemoryUsage += node.sizeOfData;
    
    _currentSize++;
    
    return YES;
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
    Node* node = [[self linkedHashMap]  getObject:key];
    
    if (node != nil)
    {
        _hitCount++;
        
        [[self linkedHashMap]  moveNode:node toPosition:0];
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
    [[self linkedHashMap]  clear];
}

@end
