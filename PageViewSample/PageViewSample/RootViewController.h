//
//  RootViewController.h
//  PageViewSample
//
//  Created by KazukiKubo on 2013/09/16.
//  Copyright (c) 2013年 KazukiKubo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController <UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;

@end
