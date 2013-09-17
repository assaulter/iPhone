//
//  FixedDateDataManagerTest.m
//  SoftSanteaTimer
//
//  Created by KazukiKubo on 2013/09/17.
//  Copyright (c) 2013年 kubo_kazuki. All rights reserved.
//

#import "FixedDateDataManagerTest.h"
#import "FixedDateDataManager.h"

@interface FixedDateDataManagerTest()
@property(nonatomic, readonly) FixedDateDataManager *manager;
@end

@implementation FixedDateDataManagerTest

-(void)setUp {
    _manager = [FixedDateDataManager sharedInstance];
}

-(void)test_insertAndDeleteFixedDate {
    FixedDate *insertObj = self.manager.insertFixedDate;
    insertObj.fixedDate = [NSDate dateWithTimeIntervalSince1970:0];
    [self.manager save];
    
    FixedDate *result = self.manager.fixedDate;
    GHAssertTrue([insertObj.fixedDate isEqualToDate:result.fixedDate], @"同じ日付である");
    
    [self.manager deleteFixedDate:insertObj];
    GHAssertNil(self.manager.fixedDate, @"削除できた(返すデータが無い場合にはnilが返却される)");
}


@end
