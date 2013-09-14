//
//  FixedDate.h
//  SoftSanteaTimer
//
//  Created by kubo_kazuki on 2013/09/15.
//  Copyright (c) 2013年 kubo_kazuki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface FixedDate : NSManagedObject

@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSDate * fixedDate;

@end
