//
//  RequestFormAPIClientTests.m
//  SoftSanteaTimer
//
//  Created by KazukiKubo on 2013/09/15.
//  Copyright (c) 2013年 kubo_kazuki. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RequestFormAPIClient.h"

@interface RequestFormAPIClientTests : XCTestCase
@property(nonatomic) RequestFormAPIClient *client;
@end

@implementation RequestFormAPIClientTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    _client = [RequestFormAPIClient new];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testExample
{
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

@end
