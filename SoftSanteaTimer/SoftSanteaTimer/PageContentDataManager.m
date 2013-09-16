//
//  PageContentDataManager.m
//  SoftSanteaTimer
//
//  Created by KazukiKubo on 2013/09/16.
//  Copyright (c) 2013年 kubo_kazuki. All rights reserved.
//

#import "PageContentDataManager.h"

@implementation PageContentDataManager

@synthesize managedObjectContext=_managedObjectContext;

static PageContentDataManager *_sharedInstance = nil;
+(PageContentDataManager *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [PageContentDataManager new];
    });
    
    return _sharedInstance;
}

#pragma mark - override property getter
-(NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    
    NSManagedObjectModel *objectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    NSPersistentStoreCoordinator *storeCordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:objectModel];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSURL *url = nil;
    
    if (paths.count > 0) {
        NSString *path = [paths objectAtIndex:0];
        path = [path stringByAppendingPathComponent:@".softsantea"];
        path = [path stringByAppendingPathComponent:@"pageContent.db"];
        url = [NSURL fileURLWithPath:path];
    }
    
    NSError *error = nil;
    NSPersistentStore *store = [storeCordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:nil options:nil error:&error];
    
    if (!store && error) {
        NSLog(@"Failed to create and persistent store. %@", [error localizedDescription]);
    }
    
    _managedObjectContext = [NSManagedObjectContext new];
    [_managedObjectContext setPersistentStoreCoordinator:storeCordinator];
    
    return _managedObjectContext;
}

-(NSArray *)pageContents {
    NSFetchRequest *request = [NSFetchRequest new];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"pageContent" inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    
    NSError *error = nil;
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (!result) {
        NSLog(@"executeFetchRequest: failed, %@", [error localizedDescription]);
        
        return nil;
    }
    
    return result;
}

@end
