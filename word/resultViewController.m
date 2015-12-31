//
//  resultViewController.m
//  word
//
//  Created by 梶原大進 on 2015/08/19.
//  Copyright (c) 2015年 梶原大進. All rights reserved.
//

#import "resultViewController.h"

@implementation resultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    allLabel.text = [NSString stringWithFormat:@"%d", self.correct + self.incorrect];
    correctLabel.text = [NSString stringWithFormat:@"%d", self.correct];
    incorrectLabel.text = [NSString stringWithFormat:@"%d", self.incorrect];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
