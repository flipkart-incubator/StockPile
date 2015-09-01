//
//  CachingException.m
//  Pods
//
//  Created by Prabodh Prakash on 27/08/15.
//
//

#import "CachingException.h"

@implementation CachingException

- (instancetype) initWithReason: (NSString*) reason
{
    self = [super initWithName:@"CoreDataDatabaseNotInitializedException" reason:reason userInfo:nil];
    return self;
}

@end
