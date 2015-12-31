//
//  editViewController.h
//  word
//
//  Created by 梶原大進 on 2015/10/10.
//  Copyright © 2015年 梶原大進. All rights reserved.
//

#import "ViewController.h"

@interface editViewController : UIViewController
<UIScrollViewDelegate, UITextFieldDelegate>
{
    IBOutlet UINavigationBar *navigation;
    //IBOutlet UITextField *title;
    
    int textTag;
    int Coordinate_Y;
}

// @property (nonatomic) UITextField *textfield;

@property (nonatomic) UITextField *titleText;

@property (nonatomic) UITextField *Qtext;
@property (nonatomic) UITextField *Atext;

@end