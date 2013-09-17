//
//  PageContentDataManager.m
//  SoftSanteaTimer
//
//  Created by KazukiKubo on 2013/09/16.
//  Copyright (c) 2013年 kubo_kazuki. All rights reserved.
//

#import "PageContentDataManager.h"

@interface PageContentDataManager() {
    NSManagedObjectContext *_managedObjectContext;
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
    NSManagedObjectModel *_managedObjectModel;
}

@property(nonatomic, readonly) NSManagedObjectModel *managedObjectModel;

@end

@implementation PageContentDataManager

@dynamic managedObjectContext, managedObjectModel;

static PageContentDataManager *_sharedInstance = nil;
+(PageContentDataManager *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [PageContentDataManager new];
    });
    
    return _sharedInstance;
}

#pragma mark - PageContent API
-(NSArray *)pageContents {
    NSFetchRequest *request = [NSFetchRequest new];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PageContent" inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    
    NSError *error = nil;
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (!result) {
        NSLog(@"executeFetchRequest: failed, %@", [error localizedDescription]);
        
        return nil;
    }
    
    return result;
}

#pragma mark - private
-(PageContent *)insertPageContent {
    PageContent *content = [NSEntityDescription insertNewObjectForEntityForName:@"PageContent" inManagedObjectContext:self.managedObjectContext];
    
    // add identifier
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    NSString *identifier = CFBridgingRelease(CFUUIDCreateString(NULL, uuid));
    content.identifier = identifier;
    
    return content;
}

-(void)save {
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Save Error ,%@", error);
    }
}

#pragma mark - initDB
-(void)initDB {
    NSArray *masterData = [self getMasterData];
    for (int i=0; i<masterData.count; i++) {
        NSDictionary *item = masterData[i];
        PageContent *content = [self insertPageContent];
        content.pageNumber = [item objectForKey:@"pageNumber"];
        content.isLastPage = [item objectForKey:@"isLastPage"];
        content.imageUrl = [item objectForKey:@"imageUrl"];
        [self save];
    }
}

-(NSArray *)getMasterData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"PageContentIntialData" ofType:@"plist"];
    
    return [NSArray arrayWithContentsOfFile:path];
}

#pragma mark - Core Data Stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    __block BOOL _isFirst;
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinatorWithIsFirstBlock:^(BOOL isFirst) {
        _isFirst = isFirst;
    }];
    
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    
    if (_isFirst) {
        [self initDB];
    }
    
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"PageContent" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinatorWithIsFirstBlock:(void(^)(BOOL isFirst))isFirstBlock
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"PageContent.sqlite"];
    isFirstBlock(![storeURL checkResourceIsReachableAndReturnError:nil]);
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory
// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end
