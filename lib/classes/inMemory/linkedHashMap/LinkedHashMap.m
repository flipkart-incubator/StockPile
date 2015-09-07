//
//  LinkedHashMap.m
//  Pods
//
//  Created by Prabodh Prakash on 01/09/15.
//
//

#import "LinkedHashMap.h"
#import "CachingException.h"

@interface LinkedHashMap()

@property (nonatomic, strong) NSMutableDictionary* lookupDictionary;
@property (nonatomic, strong) Node* startNode;
@property (nonatomic, strong) Node* endNode;

@end

@implementation LinkedHashMap

- (instancetype) initWithCapacity: (int) capacity
{
    self = [self init];
    
    if (self)
    {
        _capacity = capacity;
    }
    
    return self;
}

- (instancetype) init
{
    self = [super init];
    
    if (self)
    {
        _startNode = nil;
        _endNode = nil;
        _lookupDictionary = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (BOOL) containsValue: (Node*) node
{
    NSString* key = node.key;
    
    if ([_lookupDictionary objectForKey:key] != nil)
    {
        return true;
    }
    
    return false;
}

- (Node*) getObject: (NSString*) key
{
    Node* node = [_lookupDictionary objectForKey:key];
    
    if (node == nil)
    {
        Value* value = [_linkedHashMapDelegate getDataWithKey:key];
        
        node = [[Node alloc] initWithKey:key value:value];
        
        [_lookupDictionary setObject:node forKey:key];
    }
    
    return node;
}

- (void) clear
{
    _startNode = nil;
    _endNode = nil;
    
    [_lookupDictionary removeAllObjects];
}

- (void) putNode: (Node*) node
{
    if (node == nil)
    {
        @throw [[CachingException alloc] initWithReason:@"Node to be inserted cannot be nil"];
    }
    
    NSString* key = node.key;
    
    [_lookupDictionary setObject:node forKey:key];
    
    if (_startNode == nil)
    {
        _startNode = node;
        _startNode.previousNode = nil;
        _startNode.nextNode = nil;
    }
    else if (_endNode == nil)
    {
        _endNode = node;
        _endNode.previousNode = _startNode;
        _startNode.nextNode = node;
        _endNode.nextNode = nil;
    }
    else
    {
        _endNode.nextNode = node;
        node.previousNode = _endNode;
        _endNode = node;
    }
}

- (void) putNode: (Node*) node atIndex: (int) index
{
    NSString* key = node.key;
    
    [_lookupDictionary setObject:node forKey:key];
    
    [self moveNode:node toPosition:index];
}

- (void) moveNode: (Node*) node toPosition:(int) index
{
    Node* root = _startNode;
    int count = 0;
    
    while (count++ != index)
    {
        root = root.nextNode;
    }
    
    if (root == node)
        return;
    
    //deleting node from its original position
    node.previousNode.nextNode = node.nextNode;
    
    //case when node is the last node
    if (node.nextNode == nil)
    {
        _endNode = node.previousNode;
    }
    
    node.nextNode.previousNode = node.previousNode;
    
    node.previousNode = nil;
    node.nextNode = nil;
    
    //adding node to its new position
    root.previousNode.nextNode = node;
    
    if (root.previousNode == nil)
    {
        _startNode = node;
    }
    
    node.previousNode = root.previousNode;
    
    node.nextNode = root;
    root.previousNode = node;
    
    root = _startNode;
}

- (void) removeNodeWithKey: (NSString*) key
{
    Node* node = [_lookupDictionary objectForKey:key];
    
    if (node == nil)
    {
        return;
    }
    
    [_lookupDictionary removeObjectForKey:key];
    
    node.previousNode.nextNode = node.nextNode;
    node.nextNode.previousNode = node.previousNode;
}

- (float) removeEndNode
{
    NSString* key = _endNode.key;
    
    float sizeOccupied = _endNode.sizeOfData;
    
    [_lookupDictionary removeObjectForKey:key];
    
    _endNode.previousNode.nextNode = nil;
    
    _endNode = _endNode.previousNode;
    
    return sizeOccupied;
}

@end
