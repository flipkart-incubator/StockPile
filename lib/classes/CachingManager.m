//
//  CachingManager.m
//  Pods
//
//  Created by Prabodh Prakash on 27/08/15.
//
//

#import "CachingManager.h"

@interface CachingManager()

@property (nonatomic, assign) NSUInteger maximumInMemoryElement;

@end

@implementation CachingManager

- (instancetype)init
{
    self = [super init];
    
    return self;
}

- (void) setMaximumInMemoryElementLimit: (NSUInteger) maxNumberOfElementsInMemory
{
    _maximumInMemoryElement = maxNumberOfElementsInMemory;
}

@end
