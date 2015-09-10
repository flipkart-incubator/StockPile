//
//  CachingDatabaseHandler.m
//  Pods
//
//  Created by Prabodh Prakash on 02/09/15.
//
//

#import "CachingDatabaseHandler.h"

@implementation CachingDatabaseHandler
@synthesize path = _path;

- (BOOL) cacheNode: (Node*) node
{
    return NO;
}

- (Node*) getNodeForKey:(NSString*) key
{
    return nil;
}

- (void) clearCache
{
    
}

@end
