//
//  CachingManager.h
//  Pods
//
//  Created by Prabodh Prakash on 27/08/15.
//
//

#import <Foundation/Foundation.h>
#import "CacheProtocol.h"

@interface CachingManager : NSObject

/**
 @return newly instialized of CachingManager
 */
- (instancetype)initWithCacheType: (id<CacheProtocol>) cachingType;

/**
 sets the maximum number of elements that should be saved in memory. However, the actual number of elements stored is near to the value set by this function. It could be exact, but that is not gauranteed.
 
 @param maxNumberOfElementsInMemory maximum number of elements in memory
 */
- (void) setMaximumInMemoryElementLimit: (NSUInteger) maxNumberOfElementsInMemory;

- (void) cacheNode: (Node*) node;


@end