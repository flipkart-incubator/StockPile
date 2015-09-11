//
//  BaseCache.h
//  Pods
//
//  Created by Prabodh Prakash on 06/09/15.
//
//

#import <Foundation/Foundation.h>
#import "CacheProtocol.h"

#pragma mark protocols

@protocol CacheProtocol <NSObject>

/**
 * @param value Value that needs to be cached
 * @param key Key that needs to be used for retrieval
 */
- (BOOL) cacheValue:(Value*) value forKey:(NSString*)key;

/**
 * This method will retrieve the cached value against key. If the value is not present in memory,
 * it will look out in the mirrored and then the fallback cache.
 *
 * @param key id<NSCopying, NSMutableCopying, NSSecureCoding> type for which the cached value needs to be retrieved
 *
 * @return Retrieved cached value as Node. It returns nil if no cached value is found.
 */
- (Value*) getValueForKey:(NSString*) key;

/**
 * This method will clear all values from this cache and the mirrored and fallback cache in a cascading manner. This would be a blocking call
 */
- (void) clearCacheAndCascade;

@end

@protocol CacheAlgorithmProtocol <NSObject>

@required

//@property (nonatomic, strong, getter=path) NSString* path;

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

#pragma mark classes

@interface BaseCache : NSObject <CacheProtocol, CacheAlgorithmProtocol>

@property (nonatomic, strong) BaseCache* fallBackCache;
@property (nonatomic, strong) BaseCache* mirroredCache;

@end

//
//@interface CacheDataSource : NSObject
//
//@property (nonatomic, assign) NSInteger maximumElementInMemory;
//@property (nonatomic, assign) NSInteger maximumMemoryAllocated;
//@property (nonatomic, strong) NSString* pathForDiskCaching;
//@property (nonatomic, strong) NSString* pathForDBCaching;
//
//
////@property (nonatomic, strong) id <CacheAlgorithmProtocol> cachingDBDelegate;
////@property (nonatomic, strong) id <CacheAlgorithmProtocol> cachingDiskDelegate;
//
//@end