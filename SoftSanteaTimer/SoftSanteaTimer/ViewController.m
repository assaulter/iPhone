//
//  ViewController.m
//  SoftSanteaTimer
//
//  Created by kubo_kazuki on 2013/09/15.
//  Copyright (c) 2013年 kubo_kazuki. All rights reserved.
//

#import "ViewController.h"
#import "PageContentDataManager.h"

@interface ViewController () {
    PageContentDataManager *_manager;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"TopView";
    _manager = [PageContentDataManager sharedInstance];
    NSManagedObjectContext *context = _manager.managedObjectContext;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)pressedButton:(id)sender {
    // 初回起動時のみguideViewに遷移する。
    [self performSegueWithIdentifier:@"goToGuide" sender:self];
}

@end
