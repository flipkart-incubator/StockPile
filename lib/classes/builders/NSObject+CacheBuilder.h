//
//  NSObject+CacheBuilder.h
//  Pods
//
//  Created by Prabodh Prakash on 04/09/15.
//
//

#import <Foundation/Foundation.h>

/*!
 This class is a category over NSObject and is used to create a new instance of class using a block
 */
@interface NSObject (CacheBuilder)

- (instancetype)initUsingBlock:(void(^)(id mutableCopy))block;

@end
