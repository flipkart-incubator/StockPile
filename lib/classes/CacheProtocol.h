//
//  CacheProtocol.h
//  Pods
//
//  Created by Prabodh Prakash on 03/09/15.
//
//

#import <Foundation/Foundation.h>
#import "Node.h"

@protocol CacheFallbackProtocal <NSObject>

- (void) handleEvictedNodes: (NSArray*) evictedNodes evictedAtIndex:(int) index;

@end

@protocol CacheProtocol <NSObject>

@required

@property (nonatomic, strong, getter=path) NSString* path;

/**
 * @param node Node type that needs to be cached
 */
- (BOOL) cacheNode: (Node*) node;

/**
 * This method will retrieve the cached value against key. If the value is not present in memory,
 * it will look out in database for corresponding value.
 *
 * @param key String value for which the cached value needs to be retrieved
 *
 * @return Retrieved cached value as Node. It returns nil if no cached value is found.
 */
- (Node*) getNodeForKey:(NSString*) key;

/**
 * This method will clear all values from cache
 */
- (void) clearCache;

@end
