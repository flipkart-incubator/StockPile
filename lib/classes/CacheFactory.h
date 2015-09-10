//
//  CacheFactory.h
//  Pods
//
//  Created by Prabodh Prakash on 04/09/15.
//
//

#import <Foundation/Foundation.h>
#import "CacheProtocol.h"
#import "CachingDatabaseHandler.h"
#import "CachingDiskHandler.h"
#import "CachingManager.h"

@interface CacheFactoryDataSource : NSObject


@property (nonatomic, assign) NSInteger maximumElementInMemory;
@property (nonatomic, assign) NSInteger maximumMemoryAllocated;
@property (nonatomic, strong) NSString* pathForDiskCaching;
@property (nonatomic, strong) NSString* dbIdentifier;


@property (nonatomic, strong) id <CacheProtocol> cachingDBDelegate;
@property (nonatomic, strong) id <CacheProtocol> cachingDiskDelegate;

@end

@interface CacheFactory : NSObject

+ (id<CacheProtocol>) getCacheWithPolicy: (CachingPolicyEnum) cachePolicy cacheFactoryDataSource:(CacheFactoryDataSource*) dataSource;

@end
