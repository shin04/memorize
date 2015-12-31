//
//  contentViewController.h
//  word
//
//  Created by 梶原大進 on 2015/08/20.
//  Copyright (c) 2015年 梶原大進. All rights reserved.
//

#import "ViewController.h"

@interface contentViewController : UIViewController
<UITextFieldDelegate, UITextViewDelegate>
{
    IBOutlet UITextField *titleText;
    IBOutlet UITextView *contentText;
    IBOutlet UINavigationBar *navigation;
    
    NSString *alertStr;
}

- (IBAction)back:(id)sender;
- (IBAction)save:(id)sender;

@end
