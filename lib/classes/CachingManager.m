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

+ (id)sharedManager
{
    static CachingManager *sharedCachingManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedCachingManager = [[self alloc] init];
        
        sharedCachingManager.maximumInMemoryElement = 100;
        
    });
    
    return sharedCachingManager;
}

- (void) setMaximumInMemoryElementLimit: (NSUInteger) maxNumberOfElementsInMemory
{
    _maximumInMemoryElement = maxNumberOfElementsInMemory;
}

@end
