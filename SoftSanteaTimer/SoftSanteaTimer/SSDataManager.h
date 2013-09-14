//
//  SSDataManager.h
//  SoftSanteaTimer
//
//  Created by kubo_kazuki on 2013/09/15.
//  Copyright (c) 2013年 kubo_kazuki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "FixedDate.h"

@interface SSDataManager : NSObject

@property(nonatomic, readonly) NSManagedObjectContext *managedObjectContext;
@property(nonatomic, readonly) FixedDate *fixedDate;

+(SSDataManager *)sharedInstance;
-(FixedDate *)insertFixedDate;
@end
