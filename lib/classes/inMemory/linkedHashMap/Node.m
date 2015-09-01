//
//  Node.m
//  Pods
//
//  Created by Prabodh Prakash on 27/08/15.
//
//

#import "Node.h"

@implementation Node

- (instancetype) initWithKey: (NSString*) key value: (Value*) data
{
    self = [super init];
    
    if (self)
    {
        _key = key;
        _data = data;
        
        if (_cachingPolicy == PERSISTENCE)
        {
            [_nodeProtocolDelegate saveData:data];
        }
    }
    
    return self;
}


- (Value*) getValue
{
    return _data;
}

@end
