//
//  createViewController.h
//  word
//
//  Created by 梶原大進 on 2015/07/13.
//  Copyright (c) 2015年 梶原大進. All rights reserved.
//

#import "ViewController.h"

@interface createViewController : UIViewController
<UITextFieldDelegate, UITextViewDelegate>
{
    IBOutlet UITextField *questionText;
    IBOutlet UITextField *answerText;
    IBOutlet UINavigationBar *navigation;
    
    IBOutlet UIButton *frontBtn;
    IBOutlet UIButton *rearBtn;
    
    int key;
    int wordCount;
    int viewNumber;
}

- (IBAction)newCard:(id)sender;
- (IBAction)next:(id)sender;
- (IBAction)back:(id)sender;

- (IBAction)front:(id)sender;
- (IBAction)rear:(id)sender;

- (IBAction)ActQuestion:(id)sender;
- (IBAction)ActAnswer:(id)sender;

@end
