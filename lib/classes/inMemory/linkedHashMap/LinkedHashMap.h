//
//  LinkedHashMap.h
//  Pods
//
//  Created by Prabodh Prakash on 01/09/15.
//
//

#import <Foundation/Foundation.h>
#import "Node.h"

@protocol LinkedHashMapProtocol <NSObject>

@required

/**
 * gets the value into database
 * @param key against which data needs to be looked
 * @retun value stored in database
 */
- (Value*) getDataWithKey:(NSString*) key;

@end

@interface LinkedHashMap : NSObject

@property (nonatomic, strong) id<LinkedHashMapProtocol> linkedHashMapDelegate;

- (instancetype) initWithCapacity: (int) capacity;
- (BOOL) containsValue: (Node*) node;
- (Node*) getObject: (NSString*) key;
- (void) clear;
- (void) putNode: (Node*) node;
- (void) putNode: (Node*) node atIndex: (int) index;
- (void) moveNode: (Node*) node toPosition:(int) index;
- (void) removeNodeWithKey: (NSString*) key;
- (float) removeEndNode;

@end