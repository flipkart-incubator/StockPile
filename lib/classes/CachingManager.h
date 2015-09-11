//
//  CachingManager.h
//  Pods
//
//  Created by Prabodh Prakash on 27/08/15.
//
//

#import <Foundation/Foundation.h>
#import "CacheProtocol.h"
#import "BaseCache.h"


#pragma mark The class

@interface CachingManager : NSObject <CacheProtocol>

@property (nonatomic, strong) BaseCache* firstResponderCacheAlgo;

@end
