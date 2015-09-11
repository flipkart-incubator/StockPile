//
//  CachingDatabaseHandler.m
//  Pods
//
//  Created by Prabodh Prakash on 02/09/15.
//
//

#import "CachingDatabaseHandler.h"
#import "CoreDataLite.h"
#import "CacheTable.h"

@interface CachingDatabaseHandler()

@property (nonatomic, strong) CoreDatabaseInterface* coreDatabaseInterface;

@end

@implementation CachingDatabaseHandler

@synthesize dbName = _dbName;

- (CoreDatabaseInterface*) coreDatabaseInterface
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURL* applicationDirectoryURL =  [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        
        NSURL *urlToDB = [applicationDirectoryURL URLByAppendingPathComponent:self.dbName];
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CachingDatabase" withExtension:@"momd"];
        
        [[CoreDataManager sharedManager] setupCoreDataWithKey:self.dbName storeURL:urlToDB objectModel:[modelURL absoluteString]];
        
        _coreDatabaseInterface = [[CoreDataManager sharedManager] getCoreDataInterfaceForKey:@"CachingDBHandler"];
    });
    
    return _coreDatabaseInterface;
}

- (BOOL) cacheNode: (Node*) node
{
    __block BOOL isCachingSuccessful = true;
    
    dispatch_sync([[self coreDatabaseInterface] getSerialQueue], ^{
        
        NSManagedObjectContext* _managedObjectContext = [[self coreDatabaseInterface] getPrivateQueueManagedObjectContext];
        CacheTable* cacheTableEntity = [NSEntityDescription insertNewObjectForEntityForName:@"CacheTable" inManagedObjectContext:_managedObjectContext];
        
        cacheTableEntity.key = node.key;
        //cacheTableEntity.ttlInterval = node.data.ttlInterval;
        cacheTableEntity.ttlDate = node.data.ttlDate;
        cacheTableEntity.value = [NSKeyedArchiver archivedDataWithRootObject:node.data.value];
        
        NSError* error;
        
        if (![_managedObjectContext save:&error])
        {
            isCachingSuccessful = false;
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    });
    
    return isCachingSuccessful;
}

- (Node*) getNodeForKey:(NSString*) key
{
    __block Node* node = nil;
    dispatch_sync([[self coreDatabaseInterface] getSerialQueue], ^{
        
        NSManagedObjectContext* _managedObjectContext = [[self coreDatabaseInterface] getPrivateQueueManagedObjectContext];
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"CacheTable"
                                                  inManagedObjectContext:_managedObjectContext];
        [fetchRequest setEntity:entity];
        
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"key == %@", key];
        [fetchRequest setPredicate:predicate];
        
        NSError* error;
        
        NSArray *fetchedObjects = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
        
        if (!error && fetchedObjects != nil && fetchedObjects.count == 1)
        {
            CacheTable* cachedValue = (CacheTable*)[fetchedObjects objectAtIndex:0];
            Value* value = [[Value alloc] init];
            
            value.key = key;
            value.value = [NSKeyedUnarchiver unarchiveObjectWithData:cachedValue.value];
            value.ttlDate = cachedValue.ttlDate;
            
            node = [[Node alloc] initWithKey:key value:value];
        }
    });
    
    return node;
}

- (void) clearCache
{
    
}

@end
