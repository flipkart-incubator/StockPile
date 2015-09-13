//
//  Node.m
//  Pods
//
//  Created by Prabodh Prakash on 27/08/15.
//
//

#import "Node.h"
#import <malloc/malloc.h>

@implementation Node

- (instancetype) initWithKey: (NSString*) key value: (Value*) data
{
    self = [super init];
    
    if (self)
    {
        _key = key;
        _data = data;
        
        _sizeOfData = (float)malloc_size((__bridge const void *)(data.value))/1024.0f/1024.0f;
    }
    
    return self;
}

@end
