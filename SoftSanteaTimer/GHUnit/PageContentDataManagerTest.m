//
//  PageContentDataManagerTest.m
//  SoftSanteaTimer
//
//  Created by KazukiKubo on 2013/09/16.
//  Copyright (c) 2013年 kubo_kazuki. All rights reserved.
//

#import "PageContentDataManagerTest.h"
#import "PageContentDataManager.h"

@interface PageContentDataManagerTest()
@property(nonatomic, readonly) PageContentDataManager *manager;
@end

@implementation PageContentDataManagerTest

-(void)setUp {
    _manager = [PageContentDataManager sharedInstance];
}

-(void)tearDown {
    
}

-(void)test_getPageContents {
    NSArray *result = self.manager.pageContents;
    
    PageContent *content = result[0];
    GHAssertEquals(content.pageNumber, [NSNumber numberWithInt:0], @"0ページに該当するデータ");
    GHAssertEqualStrings(content.imageUrl, @"page1.png", @"page1.pngであること");
    GHAssertEquals(content.isLastPage, [NSNumber numberWithInt:0], @"lastPageではない");
}

@end
