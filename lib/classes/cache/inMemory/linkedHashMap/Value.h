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

@interface Value : NSObject <NSCoding>

@property (nonatomic, strong) id<NSCoding> value;

@property (nonatomic, strong) NSString* key;

@property (nonatomic, strong) NSDate* ttlDate;

@property (nonatomic) NSTimeInterval ttlInterval;

@end
