//
//  LRUCache.h
//  Pods
//
//  Created by Prabodh Prakash on 01/09/15.
//
//

#import <Foundation/Foundation.h>
#import "Node.h"

@interface LRUCache : NSObject

- (instancetype) initWithCapacity: (int) capacity;
- (void) cacheNode: (Node*) node;
- (Node*) getNodeForKey:(NSString*) key;

- (void) clearCache;

@end
