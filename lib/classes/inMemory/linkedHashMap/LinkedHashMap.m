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

@property (nonatomic, assign) int capacity;

@end

@implementation LinkedHashMap

- (instancetype) initWithCapacity: (int) capacity
{
    self = [super init];
    
    _startNode = nil;
    _endNode = nil;
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
        node.cachingPolicy = PERSISTENCE;
        
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
    
    while (count != index)
    {
        root = root.nextNode;
    }
    
    root.previousNode.nextNode = node;
    node.previousNode = root.previousNode;
    node.nextNode = root;
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

- (void) removeEndNode
{
    NSString* key = _endNode.key;
    
    [_lookupDictionary removeObjectForKey:key];
    
    if (_endNode.cachingPolicy == PERSISTENCE)
    {
        [_endNode.nodeProtocolDelegate saveData:_endNode.data];
    }
    
    _endNode.previousNode.nextNode = nil;
}

@end
