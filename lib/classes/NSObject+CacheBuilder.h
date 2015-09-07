//
//  NSObject+CacheBuilder.h
//  Pods
//
//  Created by Prabodh Prakash on 04/09/15.
//
//

#import <Foundation/Foundation.h>

@interface NSObject (CacheBuilder)

- (instancetype)initUsingBlock:(void(^)(id mutableCopy))block;

@end
