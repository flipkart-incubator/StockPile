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
#import "CachingDatabaseHandler.h"
#import "CachingDiskHandler.h"
#import "BaseCache.h"

@interface LRUCache : BaseCache

@property (nonatomic, assign) NSInteger maxElementsInMemory;
@property (nonatomic, assign) NSInteger maxMemoryAllocated;

@end
