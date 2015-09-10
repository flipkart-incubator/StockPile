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

- (BOOL) cacheNode: (Node*) node
{
    NSString *filePath = [_path stringByAppendingPathComponent:node.key];
    
    BOOL success = [NSKeyedArchiver archiveRootObject:node.data toFile:filePath];
    
    return success;
}

- (Node*) getNodeForKey:(NSString*) key
{
    NSString *filePath = [_path stringByAppendingPathComponent:key];
    Value* value = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    Node* node = [[Node alloc] initWithKey:key value:value];
    
    return node;
}

- (void) clearCache
{
    
}

@end
