//
//  CachingDiskHandler.m
//  Pods
//
//  Created by Prabodh Prakash on 04/09/15.
//
//

#import "CachingDiskHandler.h"

@implementation CachingDiskHandler

@synthesize filePath = _filePath;

- (BOOL) cacheNode: (Node*) node
{
    NSString *filePath = [self.filePath stringByAppendingPathComponent:node.key];
    
    BOOL success = [NSKeyedArchiver archiveRootObject:node.data toFile:filePath];
    
    return success;
}

- (Node*) getNodeForKey:(NSString*) key
{
    NSString *filePath = [self.filePath stringByAppendingPathComponent:key];
    Value* value = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    Node* node = [[Node alloc] initWithKey:key value:value];
    return node;
}

- (void) clearCache
{
#warning complete the code
}

@end
