//
//  GuideViewController.h
//  SoftSanteaTimer
//
//  Created by KazukiKubo on 2013/09/16.
//  Copyright (c) 2013年 kubo_kazuki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuideViewController : UIViewController<UIPageViewControllerDelegate>

// 公開しなくてもいいんだったらmファイルの方に移動する
@property(nonatomic, strong) UIPageViewController *pageViewController;

@end
