//
//  LRUDiskCache.h
//  Pods
//
//  Created by Prabodh Prakash on 04/09/15.
//
//

#import <Foundation/Foundation.h>
#import "LRUCache.h"
#import "BaseCache.h"

@interface LRUDiskCache : BaseCache

@property (nonatomic, retain) NSString* pathForDiskCaching;
@property (nonatomic, retain) id<CacheProtocol> cachingDiskProtocol;

@property (nonatomic, assign) BOOL isFallback;

@end
