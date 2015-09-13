//
//  CacheTable.h
//  Pods
//
//  Created by Prabodh Prakash on 10/09/15.
//
//

#import <CoreData/CoreData.h>

/*!
 This class is a subclass of NSManagedObject and maps to the CacheTable
 */
@interface CacheTable : NSManagedObject

/*!
 The actual data that needs to be stored. This is mandatory.
 */
@property (nonatomic, strong) NSData* value;

/*!
 A key that can uniquely identify the data. This is mandatory
 */
@property (nonatomic, strong) NSString* key;

/*!
 Instance of NSDate post which the data must be invalidated. This is optional.
 */
@property (nonatomic, strong) NSDate* ttlDate;

/*!
 This property holds the time interval - time calculated since saving of data, post which data should be invalidated.
 */
@property (nonatomic) NSTimeInterval ttlInterval;

@end
