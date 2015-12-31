//
//  DictionaryViewController.h
//  word
//
//  Created by 梶原大進 on 2015/08/20.
//  Copyright (c) 2015年 梶原大進. All rights reserved.
//

#import "ViewController.h"

@interface DictionaryViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *mytableView;
    IBOutlet UINavigationBar *navigation;
}

- (IBAction)back:(id)sender;
- (IBAction)newDic:(id)sender;

@end
