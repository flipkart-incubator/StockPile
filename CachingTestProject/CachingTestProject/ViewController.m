//
//  ViewController.m
//  CachingTestProject
//
//  Created by Prabodh Prakash on 27/08/15.
//  Copyright (c) 2015 Flipkart. All rights reserved.
//

#import "ViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define abc @"HELLO"
#define xyz @"HELLO"

@interface InMemoryCacheDataSourceImpl : NSObject<CacheDataSource>

@property (nonatomic) NSInteger pmaximumElementInMemory;
@property (nonatomic) NSInteger pmaximumMemoryAllocated;
@property (nonatomic, copy) NSString* pgetDBName;
@property (nonatomic, copy) NSString* ppathForDiskCaching;

@end

@implementation InMemoryCacheDataSourceImpl


- (NSInteger) maximumElementInMemory
{
    return 100000;
}
- (NSInteger) maximumMemoryAllocated
{
    return 250;
}

@end

@interface ViewController ()
{
    NSString *letters;
}

- (IBAction)addToCacheClicked:(id)sender;
- (IBAction)getValueClicked:(id)sender;
- (IBAction)initCacheClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *cachedValue;
@property (weak, nonatomic) IBOutlet UITextField *countOfElements;
@property (weak, nonatomic) IBOutlet UITextField *memoryAllocated;
@property (weak, nonatomic) IBOutlet UITextField *valueToAdd;
@property (weak, nonatomic) IBOutlet UITextField *valueToGet;

//@property (nonatomic,strong) CacheFactoryDataSource* dataSource;
@property (nonatomic, strong) id <CacheProtocol> cachingManager;

@end




@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self testCache];
    
    //[self testImageCaching];
    
}

- (void) testCache
{
    NSMutableString* str = [NSMutableString new];
    
    for (int i = 0 ; i < 50; i++)
    {
        [str appendString:@"a"];
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"3" ofType:@"jpg"];
    UIImage *img = [[UIImage alloc] initWithContentsOfFile:path];
    
    
    letters = [NSString stringWithString:str];
    //NSCache* cache = [NSCache new];
    
    InMemoryCacheDataSourceImpl *dataSource = [[InMemoryCacheDataSourceImpl alloc] init];
    self.cachingManager = [StockPile getInMemoryCacheUsingData:dataSource];
    
    
    float totalTimeForNSCache;
    float totalTimeForStockPile;
    int countOfElementsToCache = 10000;
    
    //caching
    NSDate* methodStart = [NSDate date];
    for (int i = 0 ; i < countOfElementsToCache ; i++)
    {
        NSString* str = [NSString stringWithFormat:@"%@%d", letters, i];
        
        [[SDImageCache sharedImageCache] storeImage:str forKey:str];
    }
    
    NSDate*methodFinish = [NSDate date];
    
    NSTimeInterval executionTime = [methodFinish timeIntervalSinceDate:methodStart];
    
    totalTimeForNSCache = executionTime;
    
    methodStart = [NSDate date];
    for (int i = 0 ; i < countOfElementsToCache ; i++)
    {
        NSString* str = [NSString stringWithFormat:@"%@%d", letters, i];
        
        
        Value* value = [[Value alloc] init];
        value.value = str;
        [self.cachingManager cacheValue:value forKey:str];
    }
    
    methodFinish = [NSDate date];
    
    executionTime = [methodFinish timeIntervalSinceDate:methodStart];
    totalTimeForStockPile = executionTime;
    NSLog(@"time for caching : %f %f", totalTimeForNSCache, totalTimeForStockPile);
    
    //access
    
    int cacheMiss = 0;
    int stockPileMiss = 0;
    
    methodStart = [NSDate date];
    for (int i = 0 ; i < countOfElementsToCache ; i++)
    {
        NSString* str = [NSString stringWithFormat:@"%@%d", letters, i];
        
        [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:str];
    }
    
    methodFinish = [NSDate date];
    
    executionTime = [methodFinish timeIntervalSinceDate:methodStart];
    
    totalTimeForNSCache = executionTime;
    
    int stockPileHit;
    methodStart = [NSDate date];
    for (int i = 0 ; i < countOfElementsToCache ; i++)
    {
        NSString* str = [NSString stringWithFormat:@"%@%d", letters, i];
        
        Value* gotObj = [self.cachingManager getValueForKey:str];
        
        if (gotObj == nil || gotObj.value == nil)
        {
            stockPileMiss++;
        }
        else
        {
            stockPileHit++;
        }
    }
    
    methodFinish = [NSDate date];
    
    executionTime = [methodFinish timeIntervalSinceDate:methodStart];
    totalTimeForStockPile = executionTime;
    
    NSLog(@"time for retriving : %f %f", totalTimeForNSCache, totalTimeForStockPile);
    
}

- (void) testImageCaching
{
    
    for (int i = 50 ; i < 500; i++)
    {
        NSLog(@"%d", i);
        NSString* urlString = [NSString stringWithFormat:@"http://dummyimage.com/%d", 1000];
        
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]];
        
        [[SDImageCache sharedImageCache] storeImage:image forKey:[NSString stringWithFormat:@"%d", i]];
    }
    
    NSDate* methodStart = [NSDate date];
    for (int i = 50 ; i < 500; i++)
    {
        [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:[NSString stringWithFormat:@"%d", i]];
    }
    NSDate*methodFinish = [NSDate date];
    
    NSTimeInterval executionTime = [methodFinish timeIntervalSinceDate:methodStart];
    
    NSLog(@"%f", executionTime);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString*)applicationDocumentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    return documentsDirectory;
}

- (IBAction)addToCacheClicked:(id)sender
{
    NSString* key = _valueToAdd.text;
    
    Value* value = [[Value alloc] init];
    value.value = key;
    
    [self.cachingManager cacheValue:value forKey:key];
}

- (IBAction)getValueClicked:(id)sender
{
    Value* data = [_cachingManager getValueForKey:_valueToGet.text];
    
    _cachedValue.text = (NSString*)data.value;
}

- (IBAction)initCacheClicked:(id)sender
{
}



@end