//
//  LRUDBCache.m
//  Pods
//
//  Created by Prabodh Prakash on 04/09/15.
//
//

#import "LRUDBCache.h"

@implementation LRUDBCache

- (BOOL) cacheNode:(Node *)node
{
    return [_cachingDatabaseDelegate cacheNode:node];
}

- (Node*) getNodeForKey:(NSString*) key
{
    return [_cachingDatabaseDelegate getNodeForKey:key];
}

- (void) clearCache
{
    
}

@end