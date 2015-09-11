//
//  StockPile.h
//  Pods
//
//  Created by Mudit Krishna Mathur on 11/09/15.
//
//

#import <Foundation/Foundation.h>
#import "CacheBuilders.h"

@interface StockPile : NSObject

+ (id<CacheProtocol>) getInMemoryCacheUsingData:(id<CacheDataSource>) dataSource;

+ (id<CacheProtocol>) getInMemoryDiskCopyCacheUsingData:(id<DiskCacheDataSource>) dataSource;

+ (id<CacheProtocol>) getInMemoryDBCopyCacheUsingData:(id<DBCacheDataSource>) dataSource;

@end
