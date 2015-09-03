//
//  CachingDatabaseHandler.h
//  Pods
//
//  Created by Prabodh Prakash on 02/09/15.
//
//

#import <Foundation/Foundation.h>
#import "Node.h"

@interface CachingDatabaseHandler : NSObject

/**
 * saves the node into database
 * @param node Node that needs to be saved into database
 */
- (void)    saveNode:           (Node*) node;

/**
 * @param key the string value against which nodes needs to be searched for in database
 * @return the Node present in database against the key
 */
- (Node*)   getNodeWithKey:     (NSString*) key;

/**
 * Node which is present against the key will be removed from database by this function
 * @param key key for which node needs to be removed from database
 */
- (void)    removeNodeWithKey:  (NSString*) key;

/**
 * updates the value of Node corresponding to a key
 * @param node updated Node value
 * @param key key against which old node value needs to be updated
 */
- (void)    updateNode: (Node*) node withKey: (NSString*) key;

@end
