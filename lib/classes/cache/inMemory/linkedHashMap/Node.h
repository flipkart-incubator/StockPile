//
//  Node.h
//  Pods
//
//  Created by Prabodh Prakash on 27/08/15.
//
//

#import <Foundation/Foundation.h>
#import "Value.h"

@class Node;

/*!
 @brief This class is primarily used to hold the key and cached value against that key
 
 @discussion This basic purpose of this class is used to hold key and cached value agains the key. To support the LinkedHashMap data structure, this class also holds reference to previous and next nodes. It also holds metdata like size of data.
 */
@interface Node : NSObject

#pragma mark data related variables

/*! This property uniquely identifies a data*/
@property (nonatomic, copy) NSString* key;

/*! This property is an instance of Value class and holds the actual data */
@property (nonatomic, strong) Value* data;

/*! This property holds the size of data 
    This property is automatically calculated in the constructor. However, this property can also be
    set from outside.
 */
@property (nonatomic, assign) float sizeOfData;

/*! This property holds the reference to previous Node */
@property (nonatomic, weak) Node* previousNode;

/*! This property holds the reference to next Node */
@property (nonatomic, strong) Node* nextNode;

/*!
 It returns new instance of a Node class.
 
 @code
 [Node initWithKey:@"key" value:someValue];
 @endcode
 
 @param key NSString that will uniquely identify this Node
 
 @param data Instance of Value class that will hold the actual data that needs to be cached.
 
 @return new instance of Node class
 */
- (instancetype) initWithKey: (NSString*) key value: (Value*) data;

@end
