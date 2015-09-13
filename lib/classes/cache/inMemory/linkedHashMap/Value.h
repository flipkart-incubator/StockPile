//
//  Value.h
//  Pods
//
//  Created by Prabodh Prakash on 28/08/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Value;

/*!
 @brief This class is used to hold the cached data and other related information.
 
 @discussion This basic purpose of this class is used to hold key and cached value agains the key. To support the LinkedHashMap data structure, this class also holds reference to previous and next nodes. It also holds metdata like size of data.
 */
@interface Value : NSObject <NSCoding>

/*!
 This property holds the cached data (or data that should be cached). This property must implement
 NSCoding protocol.
 */
@property (nonatomic, strong) id<NSCoding> value;

/*!
 This property holds the unique key associated with the data.
 */
@property (nonatomic, strong) NSString* key;

/*!
 This property holds the date at which the cached data should be invalidated.
 */
@property (nonatomic, strong) NSDate* ttlDate;

/*!
 This property holds the interval, which starts from the time of caching data, post which
 the data should be invaidated.
 */
@property (nonatomic) NSTimeInterval ttlInterval;

@end
