//
//  CacheFactory.h
//  Pods
//
//  Created by Prabodh Prakash on 03/09/15.
//
//

#import <Foundation/Foundation.h>
#import "CachingEnum.h"
#import "CacheProtocol.h"

@interface CacheFactory : NSObject

/**
 * This method is responsible creating new instance of cache type, that implementes CacheProtocol instance.
 * Both of the values elementCount and maxMemoryLimit cannot be greater than zero at same time.
 * @param elementCount this parameter takes a positive integer for caching that needs to be done on number 
 * of elements. Send any negative value to disable caching on count of elements
 * 
 * @param maxMemoryLimit this parameter takes a positive integer (that represents MB) for the amount of
 * maximum memory that must be used for cache. Send any negative value to disable caching on memory
 * 
 * @param cachingType takes ENUM that decides on type of default implemented caching
 * 
 * @return  new instance of id<CacheProtol> type
 */
 
+ (id<CacheProtocol>) getCacheWithMaxElementCount: (int) elementCount
                     maxMemoryLimit: (int) maxMemoryLimit
                       cacheType: (CachingType) cachingType;

@end
