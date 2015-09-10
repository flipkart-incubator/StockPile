//
//  ViewController.m
//  CachingTestProject
//
//  Created by Prabodh Prakash on 27/08/15.
//  Copyright (c) 2015 Flipkart. All rights reserved.
//

#import "ViewController.h"
#import <CacheLibrary.h>

@interface ViewController ()
- (IBAction)addToCacheClicked:(id)sender;
- (IBAction)getValueClicked:(id)sender;
- (IBAction)initCacheClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *cachedValue;
@property (weak, nonatomic) IBOutlet UITextField *countOfElements;
@property (weak, nonatomic) IBOutlet UITextField *memoryAllocated;
@property (weak, nonatomic) IBOutlet UITextField *valueToAdd;
@property (weak, nonatomic) IBOutlet UITextField *valueToGet;

@property (nonatomic,strong) CacheFactoryDataSource* dataSource;
@property (nonatomic, strong) id <CacheProtocol> cachingManager;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
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
    
    Node* node = [[Node alloc] initWithKey:key value:value];
    
    [_cachingManager cacheNode:node];
}

- (IBAction)getValueClicked:(id)sender
{
    Node* node = [_cachingManager getNodeForKey:_valueToGet.text];
    
    _cachedValue.text = (NSString*)node.data.value;
}

- (IBAction)initCacheClicked:(id)sender
{
    _dataSource = [[CacheFactoryDataSource alloc] init];
    _dataSource.maximumElementInMemory = [_countOfElements.text integerValue];
    _dataSource.maximumMemoryAllocated = [_memoryAllocated.text integerValue];
    _dataSource.pathForDiskCaching = [self applicationDocumentsDirectory];
    _dataSource.dbIdentifier = @"testProjectDatabase.sqlite";

    _cachingManager = [CacheFactory getCacheWithPolicy:DISK_PERSISTENCE cacheFactoryDataSource:_dataSource];
}

@end