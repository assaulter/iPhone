//
//  PageContentDataManager.h
//  SoftSanteaTimer
//
//  Created by KazukiKubo on 2013/09/16.
//  Copyright (c) 2013年 kubo_kazuki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PageContent.h"

/// 正直getだけなので、coreData使うまでもないけど
@interface PageContentDataManager : NSObject

@property(nonatomic, readonly) NSManagedObjectContext *managedObjectContext;
@property(nonatomic, readonly) NSArray *pageContents;

+(PageContentDataManager *)sharedInstance;

@end
