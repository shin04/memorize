//
//  resultViewController.h
//  word
//
//  Created by 梶原大進 on 2015/08/19.
//  Copyright (c) 2015年 梶原大進. All rights reserved.
//

#import "ViewController.h"

@interface resultViewController : UIViewController
{
    IBOutlet UILabel *allLabel;
    IBOutlet UILabel *correctLabel;
    IBOutlet UILabel *incorrectLabel;
}

@property int correct; //正解の数
@property int incorrect; //不正解の数

@end
