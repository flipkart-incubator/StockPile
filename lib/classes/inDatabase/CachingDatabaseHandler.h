//
//  CachingDatabaseHandler.h
//  Pods
//
//  Created by Prabodh Prakash on 02/09/15.
//
//

#import <Foundation/Foundation.h>
#import "Node.h"
#import "BaseCache.h"

@interface CachingDatabaseHandler : BaseCache

@property (nonatomic, copy) NSString* dbName;

@end
