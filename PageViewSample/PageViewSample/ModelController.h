//
//  ModelController.h
//  PageViewSample
//
//  Created by KazukiKubo on 2013/09/16.
//  Copyright (c) 2013年 KazukiKubo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataViewController;

@interface ModelController : NSObject <UIPageViewControllerDataSource>

- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(DataViewController *)viewController;

@end
