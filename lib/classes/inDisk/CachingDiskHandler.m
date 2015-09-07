//
//  CachingDiskHandler.m
//  Pods
//
//  Created by Prabodh Prakash on 04/09/15.
//
//

#import "CachingDiskHandler.h"

@implementation CachingDiskHandler

@synthesize path = _path;

- (void) cacheNode: (Node*) node
{
    NSString* path = [NSString stringWithFormat:@"%@/%@", _path, node.key];
    [NSKeyedArchiver archiveRootObject:node.data toFile:path];
}

- (Node*) getNodeForKey:(NSString*) key
{
    NSString* path = [NSString stringWithFormat:@"%@/%@", _path, key];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

- (void) clearCache
{
    
}

@end
