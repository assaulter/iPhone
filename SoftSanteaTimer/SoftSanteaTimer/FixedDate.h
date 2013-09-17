//
//  FixedDate.h
//  SoftSanteaTimer
//
//  Created by KazukiKubo on 2013/09/17.
//  Copyright (c) 2013年 kubo_kazuki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface FixedDate : NSManagedObject

@property (nonatomic, retain) NSDate * fixedDate;
@property (nonatomic, retain) NSString * identifier;

@end
