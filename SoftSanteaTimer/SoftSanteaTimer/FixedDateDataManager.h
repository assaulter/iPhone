//
//  FixedDateDataManager.h
//  SoftSanteaTimer
//
//  Created by KazukiKubo on 2013/09/17.
//  Copyright (c) 2013年 kubo_kazuki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FixedDate.h"

@interface FixedDateDataManager : NSObject

@property(nonatomic ,readonly) NSManagedObjectContext *managedObjectContext;
@property(nonatomic, readonly) FixedDate *fixedDate;

+(FixedDateDataManager *)sharedInstance;
-(FixedDate *)insertFixedDate;
-(BOOL)deleteFixedDate:(FixedDate *)fixedDate;
-(void)save;

@end
