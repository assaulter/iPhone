//
//  GuideModelController.h
//  SoftSanteaTimer
//
//  Created by KazukiKubo on 2013/09/17.
//  Copyright (c) 2013年 kubo_kazuki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContentViewController.h"

@interface GuideModelController : NSObject<UIPageViewControllerDataSource>

- (ContentViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(ContentViewController *)viewController;

@end
