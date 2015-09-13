//
//  CachingException.h
//  Pods
//
//  Created by Prabodh Prakash on 27/08/15.
//
//

#import <Foundation/Foundation.h>

/*!
It is a subclass of NSExpcetion that is used to raise all kinds of caching related exceptions
 */
@interface CachingException : NSException

/**
 @param reason String containing reson for crash
 
 @return The newly-initialized CoreDataException
 */
- (instancetype) initWithReason: (NSString*) reason;

@end
