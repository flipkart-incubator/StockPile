//
//  LRUDBCache.h
//  Pods
//
//  Created by Prabodh Prakash on 04/09/15.
//
//

#import <Foundation/Foundation.h>
#import "LRUCache.h"
#import "BaseCache.h"

@interface LRUDBCache : BaseCache

@property (nonatomic, retain) NSString* pathForDBCaching;
@property (nonatomic, retain) id<CacheProtocol> cachingDatabaseDelegate;

@property (nonatomic, assign) BOOL isFallback;

@end
