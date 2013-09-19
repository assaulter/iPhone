//
//  ContentViewController.h
//  SoftSanteaTimer
//
//  Created by KazukiKubo on 2013/09/17.
//  Copyright (c) 2013年 kubo_kazuki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContent.h"

@protocol  ContentViewControllerDelegate<NSObject>

-(void)pressedDismissButton;

@end

@interface ContentViewController : UIViewController

@property(weak, nonatomic) IBOutlet UIImageView *imageView;
@property(strong, nonatomic) PageContent *content;

@end
