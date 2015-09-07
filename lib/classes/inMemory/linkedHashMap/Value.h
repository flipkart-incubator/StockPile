//
//  Value.h
//  Pods
//
//  Created by Prabodh Prakash on 28/08/15.
//
//

#import <Foundation/Foundation.h>

@interface Value : NSObject <NSCoding>

@property (nonatomic, strong) id value;

@property (nonatomic, strong) NSString* key;

@property (nonatomic, strong) NSDate* ttlDate;

@property (nonatomic, assign) NSTimeInterval ttlInterval;

@end
