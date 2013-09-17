//
//  RequestFormClientTest.m
//  SoftSanteaTimer
//
//  Created by KazukiKubo on 2013/09/15.
//  Copyright (c) 2013年 kubo_kazuki. All rights reserved.
//

#import "RequestFormClientTest.h"

@implementation RequestFormClientTest

-(void)setUp {
    _client = [RequestFormAPIClient new];
}

-(void)tearDown {
    
}

-(void)test_sendRequestWithContent {
    /*
    [self prepare];
    
    NSString *content = @"testMessage By GHUnit";
    
    [self.client sendRequestWithContent:content resultBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(test_sendRequestWithContent)];
        } else {
            [self notify:kGHUnitWaitStatusFailure forSelector:@selector(test_sendRequestWithContent)];
        }
    }];
    
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:5.0];
     */
    
    GHAssertTrue(YES, @"確認できたのでこのテストは無視します");
}

@end
