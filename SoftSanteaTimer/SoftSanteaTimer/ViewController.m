//
//  ViewController.m
//  SoftSanteaTimer
//
//  Created by kubo_kazuki on 2013/09/15.
//  Copyright (c) 2013年 kubo_kazuki. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"TopView";
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
