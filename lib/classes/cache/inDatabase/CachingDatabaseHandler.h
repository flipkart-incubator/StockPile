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

/*!
 It extends BaseCache and is used to save data to database.
 */
@interface CachingDatabaseHandler : BaseCache

/*!
 Name of database.
 */
@property (nonatomic, copy) NSString* dbName;

@end
