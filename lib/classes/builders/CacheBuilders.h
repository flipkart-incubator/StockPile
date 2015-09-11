//
//  CacheFactory.h
//  Pods
//
//  Created by Prabodh Prakash on 04/09/15.
//
//

#import <Foundation/Foundation.h>
#import "BaseCache.h"
#import "CachingDatabaseHandler.h"
#import "CachingDiskHandler.h"
#import "CachingManager.h"

#pragma mark BuilderDataSources
@protocol CacheDataSource <NSObject>
- (NSInteger) maximumElementInMemory;
- (NSInteger) maximumMemoryAllocated;
@end

@protocol DiskCacheDataSource <CacheDataSource>
- (NSString*) pathForDiskCaching;
@end

@protocol DBCacheDataSource <CacheDataSource>
- (NSString*) getDBName;
@end

#pragma mark Builders

@interface CacheManagerBuilder: NSObject

typedef void (^BuilderBlock)(CachingManager *);

@property (nonatomic, strong) id <CacheDataSource> cacheDataSource;

/**
 * This method should ideally not be overridden unless you know what you are doing
 */
- (instancetype)initWithCacheDataSource:(id<CacheDataSource>) cacheDataSource;

/**
 * This method should ideally not be overridden unless you know what you are doing
 */
- (id<CacheProtocol>)build;

/**
 * Override this method while creating a custom builder
 */
- (BuilderBlock) getBuilderBlock:(id<CacheDataSource>) cacheDataSource;

@end

@interface InMemoryCacheBuilder : CacheManagerBuilder
@end

@interface InMemoryDiskCopyCacheBuilder : InMemoryCacheBuilder
@end

@interface InMemoryDbCopyCacheBuilder : InMemoryCacheBuilder
@end


