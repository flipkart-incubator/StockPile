//
//  Node.h
//  Pods
//
//  Created by Prabodh Prakash on 27/08/15.
//
//

#import <Foundation/Foundation.h>
#import "CachingEnum.h"
#import "Value.h"

@class Node;
@protocol NodeProtocol <NSObject>

@required

/**
 * saves the value into database
 * @param data the data that needs to be saved into database
 */
- (void) saveData:(Value*) data;

@end

@interface Node : NSObject

#pragma mark data related variables

/**
 * The key of the row in which data is saved
 */
@property (nonatomic, strong) NSString*     key;

/**
 * The data attached with the current node.
 */
@property (nonatomic, strong) Value*        data;

/**
 * This value stoers the caching policy for current node
 */
@property (nonatomic, assign) CachingPolicyEnum cachingPolicy;

#pragma mark delegate for NodeProtocol

/**
 * Stores the delegate for current node
 */
@property (nonatomic, assign) id <NodeProtocol> nodeProtocolDelegate;

#pragma mark splay tree related variables

/**
 * Stores the previous node of the current node
 */
@property (nonatomic, weak) Node*         previousNode;

/**
 * Stores the next node of the current node
 */
@property (nonatomic, strong) Node*         nextNode;

/**
 * @param key the NSString key with which the current node needs to be initialized
 * @param value value with which the node needs to be initialized
 * @return The newly-initialized CoreDataException
 */
- (instancetype) initWithKey: (NSString*) key value: (Value*) data NS_DESIGNATED_INITIALIZER;

/**
 * @return the current value of the node
 */
- (Value*) getValue;

@end
