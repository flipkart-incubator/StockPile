//
//  BaseCache.h
//  Pods
//
//  Created by Prabodh Prakash on 06/09/15.
//
//

#import <Foundation/Foundation.h>
#import "CacheProtocol.h"

@interface BaseCache : NSObject <CacheProtocol>

@property (nonatomic, assign) NSInteger index;

@end
