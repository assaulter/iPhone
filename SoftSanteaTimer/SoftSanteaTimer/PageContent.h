//
//  PageContent.h
//  SoftSanteaTimer
//
//  Created by KazukiKubo on 2013/09/16.
//  Copyright (c) 2013年 kubo_kazuki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PageContent : NSManagedObject

@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSNumber * pageNumber;
@property (nonatomic, retain) NSNumber * isLastPage;
@property (nonatomic, retain) NSString * imageUrl;

@end
