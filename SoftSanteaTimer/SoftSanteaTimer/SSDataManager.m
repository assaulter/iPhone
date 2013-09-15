//
//  SSDataManager.m
//  SoftSanteaTimer
//
//  Created by kubo_kazuki on 2013/09/15.
//  Copyright (c) 2013年 kubo_kazuki. All rights reserved.
//

#import "SSDataManager.h"

@interface SSDataManager()

@end

@implementation SSDataManager

@synthesize managedObjectContext=_managedObjectContext;

static SSDataManager *_sharedInstance = nil;
+(SSDataManager *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [SSDataManager new];
    });
    
    return _sharedInstance;
}

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
        path = [path stringByAppendingPathComponent:@"softsantea.db"];
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

-(FixedDate *)insertFixedDate {
    FixedDate *fixedDate = [NSEntityDescription insertNewObjectForEntityForName:@"FixedDate" inManagedObjectContext:self.managedObjectContext];
    
    // add identifier
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    NSString *identifier = CFBridgingRelease(CFUUIDCreateString(NULL, uuid));
    fixedDate.identifier = identifier;
    
    return fixedDate;
}

-(FixedDate *)fixedDate {
    // dateが最も新しいものを取得する(仕様上、完了したら削除するので0 or 1のはず・・・)
    
    NSFetchRequest *request = [NSFetchRequest new];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"FixedDate" inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    
    NSError *error = nil;
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (!result) {
        NSLog(@"executeFetchRequest: failed, %@", [error localizedDescription]);
        
        return nil;
    }
    
    return [result lastObject];
}

-(void)save {
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Save Error ,%@", error);
    }
}

@end
