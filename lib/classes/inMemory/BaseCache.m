//
//  BaseCache.m
//  Pods
//
//  Created by Prabodh Prakash on 06/09/15.
//
//

#import "BaseCache.h"
#import "CachingException.h"

@implementation BaseCache

@synthesize path;

- (void) cacheNode: (Node*) node
{
    @throw [[CachingException alloc] initWithReason:@"Must be called to a sub class of BaseCache"];
}

- (Node*) getNodeForKey:(NSString*) key
{
    @throw [[CachingException alloc] initWithReason:@"Must be called to a sub class of BaseCache"];
}

- (void) clearCache
{
    @throw [[CachingException alloc] initWithReason:@"Must be called to a sub class of BaseCache"];
}

@end
