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
@property (nonatomic, assign) float currentMemoryUsage;
@property (nonatomic, assign) int hitCount;
@property (nonatomic, assign) int missCount;

@end

@implementation LRUCache

@synthesize linkedHashMap = _linkedHashMap;

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.linkedHashMap = [[LinkedHashMap alloc] init];
    }
    
    return self;
}

- (NSArray*) cacheNode: (Node*) node error:(NSError **)outError
{
    if (_currentSize == _maxElementsInMemory)
    {
        [[self linkedHashMap]  removeEndNode];
        _currentSize--;
    }
    
    float memoryNeeded = node.sizeOfData;
    
    BOOL canCache = YES;
    NSMutableArray *removedNodes = [NSMutableArray new];
    
    while ((_maxMemoryAllocated - _currentMemoryUsage) < memoryNeeded)
    {
        Node *endNode = [[self linkedHashMap] removeEndNode];
        float memoryReduced = endNode.sizeOfData;
        
        if (memoryNeeded < 0)
        {
            canCache = NO;
            break;
        }
        
        _currentMemoryUsage -= memoryReduced;
    }
    
    if (!canCache)
    {
        *outError = [NSError errorWithDomain:@"NotEnoughMemoryError"
                                        code:-1
                                    userInfo:nil];
        return removedNodes;
    }
    
    [[self linkedHashMap] putNode:node];
    _currentMemoryUsage += node.sizeOfData;
    
    _currentSize++;
    
    return removedNodes;
}

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

- (void) clearCache
{
    _currentSize = 0;
    [[self linkedHashMap]  clear];
}

@end