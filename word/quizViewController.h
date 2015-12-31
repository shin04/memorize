//
//  quizViewController.h
//  word
//
//  Created by 梶原大進 on 2015/07/19.
//  Copyright (c) 2015年 梶原大進. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface quizViewController : UIViewController
<UITextFieldDelegate, AVAudioPlayerDelegate>
{
    IBOutlet UILabel *answerLabal;
    IBOutlet UILabel *questionLabel;
    IBOutlet UILabel *judgeLabel;
    IBOutlet UITextField *questionText;
    IBOutlet UIButton *next;
    
    int wordNumber; //カードの数を保存
    int randomNumber; //ランダム表示の乱数を記憶
    int nextCount; //問題番号を記憶
    
    NSMutableArray *randomArray; 
    
    NSString *Int;
    NSString *dicKey;
    
    AVAudioPlayer *se;
    NSString *seStr;
}

@property int correct; //正解の数
@property int incorrect; //不正解の数

- (IBAction)next:(id)sender;
- (IBAction)questionButton:(id)sender;
- (IBAction)back:(id)sender;

@end
