//
//  CachingTestProjectTests.m
//  CachingTestProjectTests
//
//  Created by Prabodh Prakash on 27/08/15.
//  Copyright (c) 2015 Flipkart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <Cache.h>

@interface CachingTestProjectTests : XCTestCase

@end

@implementation CachingTestProjectTests

CachingManager* cachingManager;


- (void)setUp
{
    [super setUp];
    CacheFactoryDataSource* dataSource = [[CacheFactoryDataSource alloc] init];
    dataSource.maximumElementInMemory = 5;
    dataSource.maximumMemoryAllocated = 1;
    cachingManager = [CacheFactory getCacheWithPolicy:MEMORY cacheFactoryDataSource:dataSource];
    
    [self cacheNodes];
}

- (void) cacheNodes
{
    Node* a = [[Node alloc] initWithKey:@"a" value:@"a"];
    Node* b = [[Node alloc] initWithKey:@"b" value:@"b"];
    Node* c = [[Node alloc] initWithKey:@"c" value:@"c"];
    Node* d = [[Node alloc] initWithKey:@"d" value:@"d"];
    Node* e = [[Node alloc] initWithKey:@"e" value:@"e"];
    
    [cachingManager cacheNode:a];
    [cachingManager cacheNode:b];
    [cachingManager cacheNode:c];
    [cachingManager cacheNode:d];
    [cachingManager cacheNode:e];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testInMemoryCaching
{NSString* a = [cachingManager getNodeForKey:@"a"];
    XCTAssertTrue([a isEqualToString:@"a"], @"Strings are not equal %@ %@", a, @"a");
    
    NSString* b = [cachingManager getNodeForKey:@"b"];
    XCTAssertTrue([b isEqualToString:@"b"], @"Strings are not equal %@ %@", b, @"b");
    
    NSString* c = [cachingManager getNodeForKey:@"c"];
    XCTAssertTrue([c isEqualToString:@"c"], @"Strings are not equal %@ %@", c, @"c");
    
    NSString* d = [cachingManager getNodeForKey:@"d"];
    XCTAssertTrue([d isEqualToString:@"d"], @"Strings are not equal %@ %@", d, @"d");
    
    NSString* e = [cachingManager getNodeForKey:@"e"];
    XCTAssertTrue([e isEqualToString:@"e"], @"Strings are not equal %@ %@", e, @"e");
    
    Node* f = [[Node alloc] initWithKey:@"f" value:@"f"];
    [cachingManager cacheNode:f];
    
    NSString* nilString = [cachingManager getNodeForKey:@"a"];
    XCTAssertTrue([nilString isEqualToString:nil], @"Strings are not equal %@ %@", nilString, nil);
    
}

@end
