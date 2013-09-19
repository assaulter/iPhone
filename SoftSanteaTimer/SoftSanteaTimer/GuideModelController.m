//
//  GuideModelController.m
//  SoftSanteaTimer
//
//  Created by KazukiKubo on 2013/09/17.
//  Copyright (c) 2013年 kubo_kazuki. All rights reserved.
//

#import "GuideModelController.h"
#import "PageContentDataManager.h"

@interface GuideModelController() {
    PageContentDataManager *_dataManager;
    NSArray *_pageContents;
}

@end

@implementation GuideModelController

- (id)init
{
    self = [super init];
    if (self) {
        // Create the data model.
        _dataManager = [PageContentDataManager sharedInstance];
        _pageContents = _dataManager.pageContents;
    }
    return self;
}

- (ContentViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{
    // Return the data view controller for the given index.
    if (([_pageContents count] == 0) || (index >= [_pageContents count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    ContentViewController *contentViewController = [storyboard instantiateViewControllerWithIdentifier:@"ContentViewController"];

    PageContent *content = _pageContents[index];
    contentViewController.content = content;

    return contentViewController;
}

- (NSUInteger)indexOfViewController:(ContentViewController *)viewController
{
    // Return the index of the given data view controller.
    // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
    
    // viewControllerからインデックスを取得してくる
    
    return [_pageContents indexOfObject:viewController.content];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(ContentViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(ContentViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [_pageContents count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

@end
