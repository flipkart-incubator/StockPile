//
//  CacheTable.h
//  Pods
//
//  Created by Prabodh Prakash on 10/09/15.
//
//

#import <CoreData/CoreData.h>

@interface CacheTable : NSManagedObject

@property (nonatomic, strong) NSData* value;

@property (nonatomic, strong) NSString* key;

@property (nonatomic, strong) NSDate* ttlDate;

@property (nonatomic) NSTimeInterval ttlInterval;

@end
