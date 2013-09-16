//
//  SSDataManagerTest.m
//  SoftSanteaTimer
//
//  Created by KazukiKubo on 2013/09/16.
//  Copyright (c) 2013年 kubo_kazuki. All rights reserved.
//

#import "SSDataManagerTest.h"
#import "SSDataManager.h"

@interface SSDataManagerTest()
@property(nonatomic, readonly) SSDataManager *manager;
@end

@implementation SSDataManagerTest

-(void)setUp {
    _manager = [SSDataManager sharedInstance];
}

-(void)test_InsertFixedDate {
    FixedDate *data = [self.manager insertFixedDate];
    GHAssertNotNil(data, @"notnill");
}

@end
