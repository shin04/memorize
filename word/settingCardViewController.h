//
//  settingCardViewController.h
//  word
//
//  Created by 梶原大進 on 2015/07/14.
//  Copyright (c) 2015年 梶原大進. All rights reserved.
//

#import "ViewController.h"

@interface settingCardViewController : UIViewController
<UITextFieldDelegate, UIScrollViewDelegate>
{
    IBOutlet UITextField *titleText;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UINavigationBar *navigation;
    
    int Coordinate_X;
    int Coordinate_Y;
}

- (IBAction)back:(id)sender;
- (IBAction)completion:(id)sender;

@end
