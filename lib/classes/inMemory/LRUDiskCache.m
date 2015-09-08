//
//  LRUDiskCache.m
//  Pods
//
//  Created by Prabodh Prakash on 04/09/15.
//
//

#import "LRUDiskCache.h"

@implementation LRUDiskCache

- (void) cacheNode:(Node *)node
{
    [_cachingDiskProtocol cacheNode:node];
}

- (Node*) getNodeForKey:(NSString *)key
{
    return [_cachingDiskProtocol getNodeForKey:key];
}

@end
