//
//  DataViewController.h
//  PageViewSample
//
//  Created by KazukiKubo on 2013/09/16.
//  Copyright (c) 2013年 KazukiKubo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) id dataObject;

@end
