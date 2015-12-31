//
//  WatchingViewController.m
//  word
//
//  Created by 梶原大進 on 2015/05/23.
//  Copyright (c) 2015年 梶原大進. All rights reserved.
//

#import "WatchingViewController.h"
#import "AppDelegate.h"

@implementation WatchingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //ナビゲーションバーを透過
    [navigation setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [navigation setShadowImage:[[UIImage alloc] init]];
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    titleLabel.text = app.titleArray[app.cellPath];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
