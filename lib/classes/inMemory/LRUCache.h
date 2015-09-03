//
//  LRUCache.h
//  Pods
//
//  Created by Prabodh Prakash on 01/09/15.
//
//

#import <Foundation/Foundation.h>
#import "Node.h"
#import "CacheProtocol.h"

@interface LRUCache : NSObject <CacheProtocol>

/**
 * If initialized using this method, a default memory limit is recommended to be provided.
 * If memory limit is not according to the requirements, use
 * initWithMemoryLimitInMB: method to initialize the LRUCache
 *
 * @param capacity integer value which tells the quantity of items in cache
 *
 * @return The newly-initialized LRUCache
 */
- (instancetype) initWithCapacity: (int) capacity;

/**
 * If initialized using this method, there should be no cap on the quantity of items that can be kept in
 * LRUCache. It should be set to INT_MAX
 *
 * @param reason integer value that specifies the cap on memory limit in MB's
 *
 * @return The newly-initialized LRUCache
 */
- (instancetype) initWithMemoryLimitInMB:(int) memoryLimit;


@end
