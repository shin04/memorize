//
//  selectViewController.h
//  word
//
//  Created by 梶原大進 on 2015/07/13.
//  Copyright (c) 2015年 梶原大進. All rights reserved.
//

#import "ViewController.h"

@interface selectViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *myTableView;
    IBOutlet UINavigationBar *navigation;
}

@end
